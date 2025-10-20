module 0x752ddfc7cff11aaa7b86971c9426febc1ca599651af924921664f8a2b663b209::sistema_universitario {
    struct Universidad has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        carreras: 0x2::vec_map::VecMap<CodigoCarrera, Carrera>,
        profesores: 0x2::vec_map::VecMap<IDProfesor, Profesor>,
        estudiantes: 0x2::vec_map::VecMap<IDEstudiante, Estudiante>,
    }

    struct Carrera has copy, drop, store {
        nombre: 0x1::string::String,
        duracion: u8,
        calificaciones: 0x2::vec_map::VecMap<IDEstudiante, u8>,
    }

    struct Profesor has copy, drop, store {
        nombre: 0x1::string::String,
        materia: 0x1::string::String,
    }

    struct Estudiante has copy, drop, store {
        nombre: 0x1::string::String,
        edad: u8,
    }

    struct CodigoCarrera has copy, drop, store {
        value: u16,
    }

    struct IDProfesor has copy, drop, store {
        value: u16,
    }

    struct IDEstudiante has copy, drop, store {
        value: u16,
    }

    public fun agregar_carrera(arg0: 0x1::string::String, arg1: u8, arg2: u16, arg3: &mut Universidad) {
        let v0 = Carrera{
            nombre         : arg0,
            duracion       : arg1,
            calificaciones : 0x2::vec_map::empty<IDEstudiante, u8>(),
        };
        let v1 = CodigoCarrera{value: arg2};
        0x2::vec_map::insert<CodigoCarrera, Carrera>(&mut arg3.carreras, v1, v0);
    }

    public fun agregar_estudiante(arg0: 0x1::string::String, arg1: u8, arg2: u16, arg3: &mut Universidad) {
        let v0 = Estudiante{
            nombre : arg0,
            edad   : arg1,
        };
        let v1 = IDEstudiante{value: arg2};
        0x2::vec_map::insert<IDEstudiante, Estudiante>(&mut arg3.estudiantes, v1, v0);
    }

    public fun agregar_profesor(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u16, arg3: &mut Universidad) {
        let v0 = Profesor{
            nombre  : arg0,
            materia : arg1,
        };
        let v1 = IDProfesor{value: arg2};
        0x2::vec_map::insert<IDProfesor, Profesor>(&mut arg3.profesores, v1, v0);
    }

    public fun asignar_calificacion(arg0: u16, arg1: u16, arg2: u8, arg3: &mut Universidad) {
        let v0 = CodigoCarrera{value: arg0};
        let v1 = IDEstudiante{value: arg1};
        0x2::vec_map::insert<IDEstudiante, u8>(&mut 0x2::vec_map::get_mut<CodigoCarrera, Carrera>(&mut arg3.carreras, &v0).calificaciones, v1, arg2);
    }

    public fun crear_universidad(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Universidad{
            id          : 0x2::object::new(arg1),
            nombre      : arg0,
            carreras    : 0x2::vec_map::empty<CodigoCarrera, Carrera>(),
            profesores  : 0x2::vec_map::empty<IDProfesor, Profesor>(),
            estudiantes : 0x2::vec_map::empty<IDEstudiante, Estudiante>(),
        };
        0x2::transfer::transfer<Universidad>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun editar_nombre_carrera(arg0: u16, arg1: 0x1::string::String, arg2: &mut Universidad) {
        let v0 = CodigoCarrera{value: arg0};
        0x2::vec_map::get_mut<CodigoCarrera, Carrera>(&mut arg2.carreras, &v0).nombre = arg1;
    }

    public fun eliminar_carrera(arg0: u16, arg1: &mut Universidad) {
        let v0 = CodigoCarrera{value: arg0};
        let (_, _) = 0x2::vec_map::remove<CodigoCarrera, Carrera>(&mut arg1.carreras, &v0);
    }

    public fun eliminar_universidad(arg0: Universidad) {
        let Universidad {
            id          : v0,
            nombre      : _,
            carreras    : _,
            profesores  : _,
            estudiantes : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

