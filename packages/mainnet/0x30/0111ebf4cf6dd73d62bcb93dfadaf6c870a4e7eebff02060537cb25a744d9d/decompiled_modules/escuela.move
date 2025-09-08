module 0x300111ebf4cf6dd73d62bcb93dfadaf6c870a4e7eebff02060537cb25a744d9d::escuela {
    struct Escuela has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        propietario: address,
        cursos: 0x2::vec_map::VecMap<u64, Curso>,
    }

    struct Curso has drop, store {
        id: u64,
        titulo: 0x1::string::String,
        instructor_nombre: 0x1::string::String,
        descripcion: 0x1::string::String,
        disponible: bool,
        costo: u64,
    }

    struct AccesoCurso has store, key {
        id: 0x2::object::UID,
        curso_id: u64,
        propietario: address,
    }

    public fun actualizar_curso(arg0: &mut Escuela, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg6), 13906834453516517381);
        assert!(0x2::vec_map::contains<u64, Curso>(&arg0.cursos, &arg1), 13906834457811353603);
        let v0 = 0x2::vec_map::get_mut<u64, Curso>(&mut arg0.cursos, &arg1);
        v0.titulo = arg2;
        v0.instructor_nombre = arg3;
        v0.descripcion = arg4;
        v0.costo = arg5;
    }

    public fun comprar_curso(arg0: &mut Escuela, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, AccesoCurso) {
        assert!(0x2::vec_map::contains<u64, Curso>(&arg0.cursos, &arg1), 13906834573775470595);
        let v0 = 0x2::vec_map::get<u64, Curso>(&arg0.cursos, &arg1);
        let v1 = v0.costo;
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0.disponible, 13906834599545536519);
        assert!(v2 >= v1, 13906834603840634889);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.propietario);
        let v3 = AccesoCurso{
            id          : 0x2::object::new(arg3),
            curso_id    : v0.id,
            propietario : 0x2::tx_context::sender(arg3),
        };
        (0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2 - v1, arg3), v3)
    }

    public fun crear_curso(arg0: &mut Escuela, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg6), 13906834419156779013);
        assert!(!0x2::vec_map::contains<u64, Curso>(&arg0.cursos, &arg1), 13906834423451484161);
        let v0 = Curso{
            id                : arg1,
            titulo            : arg2,
            instructor_nombre : arg3,
            descripcion       : arg4,
            disponible        : true,
            costo             : arg5,
        };
        0x2::vec_map::insert<u64, Curso>(&mut arg0.cursos, arg1, v0);
    }

    public fun crear_escuela(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Escuela{
            id          : 0x2::object::new(arg1),
            nombre      : arg0,
            propietario : 0x2::tx_context::sender(arg1),
            cursos      : 0x2::vec_map::empty<u64, Curso>(),
        };
        0x2::transfer::transfer<Escuela>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_curso(arg0: &mut Escuela, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 13906834500761157637);
        assert!(0x2::vec_map::contains<u64, Curso>(&arg0.cursos, &arg1), 13906834505055993859);
        let (_, _) = 0x2::vec_map::remove<u64, Curso>(&mut arg0.cursos, &arg1);
    }

    public fun eliminar_escuela(arg0: Escuela, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg1), 13906834530825928709);
        let Escuela {
            id          : v0,
            nombre      : _,
            propietario : _,
            cursos      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

