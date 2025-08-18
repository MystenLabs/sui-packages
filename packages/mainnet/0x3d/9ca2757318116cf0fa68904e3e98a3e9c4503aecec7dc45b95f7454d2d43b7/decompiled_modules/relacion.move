module 0x3d9ca2757318116cf0fa68904e3e98a3e9c4503aecec7dc45b95f7454d2d43b7::relacion {
    struct Relacion has store, key {
        id: 0x2::object::UID,
        alumnos: 0x2::vec_map::VecMap<u64, Alumno>,
    }

    struct Alumno has copy, drop, store {
        nombre: 0x1::string::String,
        boleta: 0x1::string::String,
        status: bool,
    }

    public fun actualizar_boleta(arg0: &mut Relacion, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Alumno>(&arg0.alumnos, &arg1), 52);
        0x2::vec_map::get_mut<u64, Alumno>(&mut arg0.alumnos, &arg1).boleta = arg2;
    }

    public fun actualizar_disponibilidad(arg0: &mut Relacion, arg1: u64, arg2: bool) {
        assert!(0x2::vec_map::contains<u64, Alumno>(&arg0.alumnos, &arg1), 52);
        0x2::vec_map::get_mut<u64, Alumno>(&mut arg0.alumnos, &arg1).status = arg2;
    }

    public fun actualizar_nombre(arg0: &mut Relacion, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Alumno>(&arg0.alumnos, &arg1), 52);
        0x2::vec_map::get_mut<u64, Alumno>(&mut arg0.alumnos, &arg1).nombre = arg2;
    }

    public fun agregar_alumno(arg0: &mut Relacion, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool) {
        let v0 = Alumno{
            nombre : arg2,
            boleta : arg3,
            status : arg4,
        };
        assert!(!0x2::vec_map::contains<u64, Alumno>(&arg0.alumnos, &arg1), 51);
        0x2::vec_map::insert<u64, Alumno>(&mut arg0.alumnos, arg1, v0);
    }

    public fun borrar_alumno(arg0: &mut Relacion, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Alumno>(&arg0.alumnos, &arg1), 52);
        let (_, _) = 0x2::vec_map::remove<u64, Alumno>(&mut arg0.alumnos, &arg1);
    }

    public fun crear_relacion(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Relacion{
            id      : 0x2::object::new(arg0),
            alumnos : 0x2::vec_map::empty<u64, Alumno>(),
        };
        0x2::transfer::transfer<Relacion>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_relacion(arg0: Relacion) {
        let Relacion {
            id      : v0,
            alumnos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

