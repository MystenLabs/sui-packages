module 0xcc5575858502ba958960a05dd0899bc79995c0b4468b38f904109122ce7d32e4::cafeteria {
    struct Queue has drop, store {
        items: vector<0x1::string::String>,
        front: u64,
    }

    struct QueueSystem has key {
        id: 0x2::object::UID,
        alumnos: Queue,
        trabajadores: Queue,
    }

    entry fun add_alumno(arg0: &mut QueueSystem, arg1: 0x1::string::String) {
        llega_alumno(arg0, arg1);
    }

    entry fun add_trabajador(arg0: &mut QueueSystem, arg1: 0x1::string::String) {
        llega_trabajador(arg0, arg1);
    }

    entry fun atender(arg0: &mut QueueSystem) : 0x1::string::String {
        atiende(arg0)
    }

    public fun atiende(arg0: &mut QueueSystem) : 0x1::string::String {
        if (!is_empty(&arg0.trabajadores)) {
            let v0 = &mut arg0.trabajadores;
            pop(v0);
            return front(&arg0.trabajadores)
        };
        if (!is_empty(&arg0.alumnos)) {
            let v1 = &mut arg0.alumnos;
            pop(v1);
            return front(&arg0.alumnos)
        };
        0x1::string::utf8(b"")
    }

    entry fun create_system(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<QueueSystem>(init_system(arg0));
    }

    public fun front(arg0: &Queue) : 0x1::string::String {
        if (is_empty(arg0)) {
            return 0x1::string::utf8(b"")
        };
        *0x1::vector::borrow<0x1::string::String>(&arg0.items, arg0.front)
    }

    public fun init_system(arg0: &mut 0x2::tx_context::TxContext) : QueueSystem {
        QueueSystem{
            id           : 0x2::object::new(arg0),
            alumnos      : new_queue(),
            trabajadores : new_queue(),
        }
    }

    public fun is_empty(arg0: &Queue) : bool {
        arg0.front >= 0x1::vector::length<0x1::string::String>(&arg0.items)
    }

    public fun llega_alumno(arg0: &mut QueueSystem, arg1: 0x1::string::String) {
        let v0 = &mut arg0.alumnos;
        push(v0, arg1);
    }

    public fun llega_trabajador(arg0: &mut QueueSystem, arg1: 0x1::string::String) {
        let v0 = &mut arg0.trabajadores;
        push(v0, arg1);
    }

    public fun new_queue() : Queue {
        Queue{
            items : 0x1::vector::empty<0x1::string::String>(),
            front : 0,
        }
    }

    public fun pop(arg0: &mut Queue) {
        if (!is_empty(arg0)) {
            arg0.front = arg0.front + 1;
        };
    }

    public fun push(arg0: &mut Queue, arg1: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.items, arg1);
    }

    // decompiled from Move bytecode v6
}

