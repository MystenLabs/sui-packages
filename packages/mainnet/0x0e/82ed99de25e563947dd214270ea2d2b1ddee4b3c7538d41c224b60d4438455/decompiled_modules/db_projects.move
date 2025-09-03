module 0xe82ed99de25e563947dd214270ea2d2b1ddee4b3c7538d41c224b60d4438455::db_projects {
    struct Proyecto has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        repo: 0x1::string::String,
        miembros: 0x2::vec_map::VecMap<0x1::string::String, Miembros>,
    }

    struct Miembros has drop, store {
        nombre: 0x1::string::String,
        puesto: 0x1::string::String,
        nivel: 0x1::string::String,
        estado: 0x1::string::String,
    }

    public fun actualizar_mienbro(arg0: &mut Proyecto, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Miembros>(&arg0.miembros, &arg1), 13906834406271746051);
    }

    public fun agregar_mienbro(arg0: &mut Proyecto, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<0x1::string::String, Miembros>(&arg0.miembros, &arg1), 13906834346142072833);
        let v0 = Miembros{
            nombre : arg1,
            puesto : arg2,
            nivel  : arg3,
            estado : 0x1::string::utf8(b"activo"),
        };
        0x2::vec_map::insert<0x1::string::String, Miembros>(&mut arg0.miembros, arg1, v0);
    }

    public fun borrar_mienbro(arg0: &mut Proyecto, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Miembros>(&arg0.miembros, &arg1), 13906834466401288195);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, Miembros>(&mut arg0.miembros, &arg1);
    }

    public fun crear_proyecto(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Proyecto{
            id       : 0x2::object::new(arg2),
            nombre   : arg0,
            repo     : arg1,
            miembros : 0x2::vec_map::empty<0x1::string::String, Miembros>(),
        };
        0x2::transfer::transfer<Proyecto>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

