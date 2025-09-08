module 0x1eed4843140a720e38353dcdb901187a301dfc97faa61f6af569a55b3766dd9c::historical_databases {
    struct Clinica has store, key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        pacientes: 0x2::vec_map::VecMap<u64, Paciente>,
    }

    struct Paciente has drop, store {
        id_paciente: u64,
        nombre: 0x1::string::String,
        historial: 0x2::vec_map::VecMap<u64, Consulta>,
        prox_id_consulta: u64,
    }

    struct Consulta has drop, store {
        consulta_id: u64,
        fecha: 0x1::string::String,
        medico: 0x1::string::String,
        diagnostico: 0x1::string::String,
        tratamiento: 0x1::string::String,
        notas: 0x1::string::String,
        estado: 0x1::string::String,
    }

    public fun actualizar_consulta(arg0: &mut Clinica, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 13906834565185536003);
        let v0 = 0x2::vec_map::get_mut<u64, Paciente>(&mut arg0.pacientes, &arg1);
        assert!(0x2::vec_map::contains<u64, Consulta>(&v0.historial, &arg2), 13906834573775601667);
        let v1 = 0x2::vec_map::get_mut<u64, Consulta>(&mut v0.historial, &arg2);
        assert!(v1.estado == 0x1::string::utf8(b"Abierta"), 13906834582365601798);
        v1.diagnostico = arg3;
        v1.tratamiento = arg4;
        v1.notas = arg5;
    }

    public fun agregar_consulta(arg0: &mut Clinica, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 13906834449221419011);
        let v0 = 0x2::vec_map::get_mut<u64, Paciente>(&mut arg0.pacientes, &arg1);
        let v1 = v0.prox_id_consulta;
        assert!(!0x2::vec_map::contains<u64, Consulta>(&v0.historial, &v1), 13906834466401419267);
        let v2 = Consulta{
            consulta_id : v1,
            fecha       : arg2,
            medico      : arg3,
            diagnostico : arg4,
            tratamiento : arg5,
            notas       : arg6,
            estado      : 0x1::string::utf8(b"Abierta"),
        };
        0x2::vec_map::insert<u64, Consulta>(&mut v0.historial, v1, v2);
        v0.prox_id_consulta = v1 + 1;
    }

    public fun borrar_consulta(arg0: &mut Clinica, arg1: u64, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 13906834702624489475);
        let v0 = 0x2::vec_map::get_mut<u64, Paciente>(&mut arg0.pacientes, &arg1);
        assert!(0x2::vec_map::contains<u64, Consulta>(&v0.historial, &arg2), 13906834711214555139);
        let (_, _) = 0x2::vec_map::remove<u64, Consulta>(&mut v0.historial, &arg2);
    }

    public fun cerrar_consulta(arg0: &mut Clinica, arg1: u64, arg2: u64, arg3: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 13906834638199980035);
        let v0 = 0x2::vec_map::get_mut<u64, Paciente>(&mut arg0.pacientes, &arg1);
        assert!(0x2::vec_map::contains<u64, Consulta>(&v0.historial, &arg2), 13906834646790045699);
        let v1 = 0x2::vec_map::get_mut<u64, Consulta>(&mut v0.historial, &arg2);
        assert!(v1.estado == 0x1::string::utf8(b"Abierta"), 13906834655380045830);
        v1.notas = arg3;
        v1.estado = 0x1::string::utf8(b"Cerrada");
    }

    public fun crear_clinica(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Clinica{
            id        : 0x2::object::new(arg1),
            nombre    : arg0,
            pacientes : 0x2::vec_map::empty<u64, Paciente>(),
        };
        0x2::transfer::transfer<Clinica>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_paciente(arg0: &mut Clinica, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 13906834427746582531);
        let (_, _) = 0x2::vec_map::remove<u64, Paciente>(&mut arg0.pacientes, &arg1);
    }

    public fun registrar_paciente(arg0: &mut Clinica, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 13906834380501811201);
        let v0 = Paciente{
            id_paciente      : arg1,
            nombre           : arg2,
            historial        : 0x2::vec_map::empty<u64, Consulta>(),
            prox_id_consulta : 0,
        };
        0x2::vec_map::insert<u64, Paciente>(&mut arg0.pacientes, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

