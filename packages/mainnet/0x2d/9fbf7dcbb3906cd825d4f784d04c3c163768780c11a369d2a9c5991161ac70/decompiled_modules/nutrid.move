module 0x2d9fbf7dcbb3906cd825d4f784d04c3c163768780c11a369d2a9c5991161ac70::nutrid {
    struct Directorio has store, key {
        id: 0x2::object::UID,
        pacientes: 0x2::vec_map::VecMap<u64, Paciente>,
    }

    struct Paciente has copy, drop, store {
        nombre: 0x1::string::String,
        apellido: 0x1::string::String,
        edad: u8,
        estatura: u8,
        peso: u16,
    }

    public fun actualizar_edad(arg0: &mut Directorio, arg1: u64, arg2: u8) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 2);
        0x2::vec_map::get_mut<u64, Paciente>(&mut arg0.pacientes, &arg1).edad = arg2;
    }

    public fun actualizar_peso(arg0: &mut Directorio, arg1: u64, arg2: u16) {
        assert!(0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 2);
        0x2::vec_map::get_mut<u64, Paciente>(&mut arg0.pacientes, &arg1).peso = arg2;
    }

    public fun crear_directorio(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Directorio{
            id        : 0x2::object::new(arg0),
            pacientes : 0x2::vec_map::empty<u64, Paciente>(),
        };
        0x2::transfer::transfer<Directorio>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun registrar_paciente(arg0: &mut Directorio, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u8, arg6: u16) {
        let v0 = Paciente{
            nombre   : arg2,
            apellido : arg3,
            edad     : arg4,
            estatura : arg5,
            peso     : arg6,
        };
        assert!(!0x2::vec_map::contains<u64, Paciente>(&arg0.pacientes, &arg1), 1);
        0x2::vec_map::insert<u64, Paciente>(&mut arg0.pacientes, arg1, v0);
    }

    // decompiled from Move bytecode v6
}

