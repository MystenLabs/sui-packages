module 0xe5a939fccafcda598ff4c00cbbf751b004a11531f5ba9d9224b440954b41448f::escuela {
    struct Escuela has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        alumnos: 0x2::vec_map::VecMap<Matricula, Alumno>,
    }

    struct Alumno has copy, drop, store {
        nombre: 0x1::string::String,
        edad: u8,
        promedio: u8,
        inscrito: bool,
    }

    struct Matricula has copy, drop, store {
        value: u16,
    }

    public fun actualizar_promedio(arg0: u16, arg1: u8, arg2: &mut Escuela) {
        let v0 = Matricula{value: arg0};
        0x2::vec_map::get_mut<Matricula, Alumno>(&mut arg2.alumnos, &v0).promedio = arg1;
    }

    public fun agregar_alumno(arg0: 0x1::string::String, arg1: u8, arg2: u8, arg3: u16, arg4: &mut Escuela) {
        let v0 = Alumno{
            nombre   : arg0,
            edad     : arg1,
            promedio : arg2,
            inscrito : true,
        };
        let v1 = Matricula{value: arg3};
        0x2::vec_map::insert<Matricula, Alumno>(&mut arg4.alumnos, v1, v0);
    }

    public fun cambiar_estado_inscripcion(arg0: u16, arg1: &mut Escuela) {
        let v0 = Matricula{value: arg0};
        let v1 = 0x2::vec_map::get_mut<Matricula, Alumno>(&mut arg1.alumnos, &v0);
        v1.inscrito = !v1.inscrito;
    }

    public fun crear_escuela(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Escuela{
            id      : 0x2::object::new(arg1),
            nombre  : arg0,
            alumnos : 0x2::vec_map::empty<Matricula, Alumno>(),
        };
        0x2::transfer::transfer<Escuela>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_alumno(arg0: u16, arg1: &mut Escuela) {
        let v0 = Matricula{value: arg0};
        let (_, _) = 0x2::vec_map::remove<Matricula, Alumno>(&mut arg1.alumnos, &v0);
    }

    public fun eliminar_escuela(arg0: Escuela) {
        let Escuela {
            id      : v0,
            nombre  : _,
            alumnos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

