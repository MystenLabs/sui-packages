module 0xf916a79b5310fd21e239134759ac740d6cd06f2eb248733fb994e4656662cca6::universidad {
    struct Universidad has key {
        id: 0x2::object::UID,
        nombreU: 0x1::string::String,
        estudiantes: 0x2::vec_map::VecMap<u64, Estudiante>,
        materias: 0x2::vec_map::VecMap<u64, Materia>,
    }

    struct Estudiante has drop, store {
        matricula: u64,
        nombreA: 0x1::string::String,
        carrera: 0x1::string::String,
        semestre: u8,
        estado: bool,
        materiasAlu: vector<u64>,
    }

    struct Materia has drop, store {
        clave: u64,
        nombreM: 0x1::string::String,
        creditos: u8,
        profesor: 0x1::string::String,
    }

    public fun actualizar_estado(arg0: &mut Universidad, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Estudiante>(&arg0.estudiantes, &arg1), 13906834612430176259);
        let v0 = 0x2::vec_map::get_mut<u64, Estudiante>(&mut arg0.estudiantes, &arg1);
        v0.estado = !v0.estado;
    }

    public fun agregar_estudiante(arg0: &mut Universidad, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8) {
        assert!(!0x2::vec_map::contains<u64, Estudiante>(&arg0.estudiantes, &arg1), 13906834440631353345);
        let v0 = Estudiante{
            matricula   : arg1,
            nombreA     : arg2,
            carrera     : arg3,
            semestre    : arg4,
            estado      : true,
            materiasAlu : vector[],
        };
        0x2::vec_map::insert<u64, Estudiante>(&mut arg0.estudiantes, arg1, v0);
    }

    public fun agregar_materia(arg0: &mut Universidad, arg1: u64, arg2: 0x1::string::String, arg3: u8, arg4: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u64, Materia>(&arg0.materias, &arg1), 13906834509351092229);
        let v0 = Materia{
            clave    : arg1,
            nombreM  : arg2,
            creditos : arg3,
            profesor : arg4,
        };
        0x2::vec_map::insert<u64, Materia>(&mut arg0.materias, arg1, v0);
    }

    public fun agregar_materiaAlu(arg0: &mut Universidad, arg1: u64, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, Estudiante>(&arg0.estudiantes, &arg1), 13906834569480503299);
        assert!(0x2::vec_map::contains<u64, Materia>(&arg0.materias, &arg2), 13906834573775732743);
        0x1::vector::push_back<u64>(&mut 0x2::vec_map::get_mut<u64, Estudiante>(&mut arg0.estudiantes, &arg1).materiasAlu, arg2);
    }

    public fun borrar_estudiante(arg0: &mut Universidad, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Estudiante>(&arg0.estudiantes, &arg1), 13906834655379849219);
        let (_, _) = 0x2::vec_map::remove<u64, Estudiante>(&mut arg0.estudiantes, &arg1);
    }

    public fun borrar_materia(arg0: &mut Universidad, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Materia>(&arg0.materias, &arg1), 13906834689739849735);
        let (_, _) = 0x2::vec_map::remove<u64, Materia>(&mut arg0.materias, &arg1);
    }

    public fun crear_universidad(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Universidad{
            id          : 0x2::object::new(arg1),
            nombreU     : arg0,
            estudiantes : 0x2::vec_map::empty<u64, Estudiante>(),
            materias    : 0x2::vec_map::empty<u64, Materia>(),
        };
        0x2::transfer::transfer<Universidad>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

