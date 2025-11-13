module 0x313d461e1eb560b5215d9ac61f02e7f2413ddfca3d000df76ea3fa39ab680663::desafio_lista_tarefas {
    struct TodoList has store, key {
        id: 0x2::object::UID,
        items: vector<0x1::string::String>,
    }

    public entry fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TodoList{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::transfer<TodoList>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun adicionar_tarefa(arg0: &mut TodoList, arg1: vector<u8>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, 0x1::string::utf8(arg1));
    }

    public entry fun alterar_tarefa(arg0: &mut TodoList, arg1: u64, arg2: vector<u8>) {
        if (arg1 >= 0x1::vector::length<0x1::string::String>(&arg0.items)) {
            abort 1
        };
        *0x1::vector::borrow_mut<0x1::string::String>(&mut arg0.items, arg1) = 0x1::string::utf8(arg2);
    }

    public entry fun limpar_tarefas(arg0: &mut TodoList) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.items)) {
            0x1::vector::pop_back<0x1::string::String>(&mut arg0.items);
            v0 = v0 + 1;
        };
    }

    public fun listar_tarefas(arg0: &TodoList) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.items)) {
            0x1::debug::print<0x1::string::String>(0x1::vector::borrow<0x1::string::String>(&arg0.items, v0));
            v0 = v0 + 1;
        };
    }

    public fun obter_tarefa(arg0: &TodoList, arg1: u64) : 0x1::string::String {
        if (arg1 >= 0x1::vector::length<0x1::string::String>(&arg0.items)) {
            abort 1
        };
        *0x1::vector::borrow<0x1::string::String>(&arg0.items, arg1)
    }

    public fun quantidade_tarefas(arg0: &TodoList) : u64 {
        0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public entry fun remover_tarefa(arg0: &mut TodoList, arg1: u64) {
        if (arg1 >= 0x1::vector::length<0x1::string::String>(&arg0.items)) {
            abort 1
        };
        0x1::vector::remove<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

