describe 'Cadastrar' do

    def login(field_email, field_password)
        @body = {
            session:{
                email: field_email,
                password: field_password
            }
        }.to_json

        @login = Login.post('/sessions', body: @body)
    end

    context 'tarefas' do

    before{
        login('brunobatista66@gmail.com', '123456')    }

        it 'com sucesso' do
            @header = {
                'Content-Type': 'application/json',
                Accept: 'application/vnd.tasksmanager.v2',
                Authorization: @login.parsed_response['data']['attributes']['auth-token']
            }

            @body = {
                task:{
                   title: 'Criei tarefa',
                   description: 'Descrição da tarefa',
                   deadline: '2019-01-22 15:00:00',
                   done: true
                }
            }.to_json

            @tarefa = Cadastrar.post('/tasks', body: @body, header: @header)
            puts @tarefa
            expect(@tarefa.parsed_response['data']['attributes']['title']).to eq 'Criei tarefa'

        end
    end
end
