module 0xab8cc063cbc10e5e8856c32790c064201ba88a511e1639c5b291dabc9624d316::control {
    struct ControlAsistencia has store, key {
        id: 0x2::object::UID,
        personas: 0x2::vec_map::VecMap<u64, Persona>,
    }

    struct Persona has copy, drop, store {
        nombre: 0x1::string::String,
        presente: bool,
        fecha: 0x1::string::String,
    }

    public fun actualizar_asistencia(arg0: &mut ControlAsistencia, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Persona>(&arg0.personas, &arg1), 11);
        0x2::vec_map::get_mut<u64, Persona>(&mut arg0.personas, &arg1).presente = arg2;
    }

    public fun actualizar_fecha(arg0: &mut ControlAsistencia, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Persona>(&arg0.personas, &arg1), 11);
        0x2::vec_map::get_mut<u64, Persona>(&mut arg0.personas, &arg1).fecha = arg2;
    }

    public fun actualizar_nombre(arg0: &mut ControlAsistencia, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Persona>(&arg0.personas, &arg1), 11);
        0x2::vec_map::get_mut<u64, Persona>(&mut arg0.personas, &arg1).nombre = arg2;
    }

    public fun agregar_persona(arg0: &mut ControlAsistencia, arg1: u64, arg2: 0x1::string::String, arg3: bool, arg4: 0x1::string::String) {
        let v0 = Persona{
            nombre   : arg2,
            presente : arg3,
            fecha    : arg4,
        };
        assert!(!0x2::vec_map::contains<u64, Persona>(&arg0.personas, &arg1), 10);
        0x2::vec_map::insert<u64, Persona>(&mut arg0.personas, arg1, v0);
    }

    public fun borrar_persona(arg0: &mut ControlAsistencia, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Persona>(&arg0.personas, &arg1), 11);
        let (_, _) = 0x2::vec_map::remove<u64, Persona>(&mut arg0.personas, &arg1);
    }

    public fun crear_control(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ControlAsistencia{
            id       : 0x2::object::new(arg0),
            personas : 0x2::vec_map::empty<u64, Persona>(),
        };
        0x2::transfer::transfer<ControlAsistencia>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_control(arg0: ControlAsistencia) {
        let ControlAsistencia {
            id       : v0,
            personas : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

