module 0xeb21012d5e0e293cfb33ac8d983a977f4c05d7054ac75d48f27c8ddec464720a::liga_deportiva {
    struct Liga has key {
        id: 0x2::object::UID,
        nombre: 0x1::string::String,
        equipos: 0x2::vec_map::VecMap<IDEquipo, Equipo>,
    }

    struct Equipo has copy, drop, store {
        nombre: 0x1::string::String,
        ciudad: 0x1::string::String,
        jugadores: 0x2::vec_map::VecMap<IDJugador, Jugador>,
    }

    struct Jugador has copy, drop, store {
        nombre: 0x1::string::String,
        edad: u8,
        posicion: 0x1::string::String,
        activo: bool,
    }

    struct IDEquipo has copy, drop, store {
        value: u16,
    }

    struct IDJugador has copy, drop, store {
        value: u16,
    }

    public fun actualizar_estado_jugador(arg0: u16, arg1: u16, arg2: &mut Liga) {
        let v0 = IDEquipo{value: arg1};
        let v1 = IDJugador{value: arg0};
        let v2 = 0x2::vec_map::get_mut<IDJugador, Jugador>(&mut 0x2::vec_map::get_mut<IDEquipo, Equipo>(&mut arg2.equipos, &v0).jugadores, &v1);
        v2.activo = !v2.activo;
    }

    public fun agregar_equipo(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u16, arg3: &mut Liga) {
        let v0 = Equipo{
            nombre    : arg0,
            ciudad    : arg1,
            jugadores : 0x2::vec_map::empty<IDJugador, Jugador>(),
        };
        let v1 = IDEquipo{value: arg2};
        0x2::vec_map::insert<IDEquipo, Equipo>(&mut arg3.equipos, v1, v0);
    }

    public fun agregar_jugador(arg0: 0x1::string::String, arg1: u8, arg2: 0x1::string::String, arg3: u16, arg4: u16, arg5: &mut Liga) {
        let v0 = IDEquipo{value: arg4};
        let v1 = Jugador{
            nombre   : arg0,
            edad     : arg1,
            posicion : arg2,
            activo   : true,
        };
        let v2 = IDJugador{value: arg3};
        0x2::vec_map::insert<IDJugador, Jugador>(&mut 0x2::vec_map::get_mut<IDEquipo, Equipo>(&mut arg5.equipos, &v0).jugadores, v2, v1);
    }

    public fun crear_liga(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Liga{
            id      : 0x2::object::new(arg1),
            nombre  : arg0,
            equipos : 0x2::vec_map::empty<IDEquipo, Equipo>(),
        };
        0x2::transfer::transfer<Liga>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun editar_nombre_equipo(arg0: u16, arg1: 0x1::string::String, arg2: &mut Liga) {
        let v0 = IDEquipo{value: arg0};
        0x2::vec_map::get_mut<IDEquipo, Equipo>(&mut arg2.equipos, &v0).nombre = arg1;
    }

    public fun eliminar_equipo(arg0: u16, arg1: &mut Liga) {
        let v0 = IDEquipo{value: arg0};
        let (_, _) = 0x2::vec_map::remove<IDEquipo, Equipo>(&mut arg1.equipos, &v0);
    }

    public fun eliminar_jugador(arg0: u16, arg1: u16, arg2: &mut Liga) {
        let v0 = IDEquipo{value: arg1};
        let v1 = IDJugador{value: arg0};
        let (_, _) = 0x2::vec_map::remove<IDJugador, Jugador>(&mut 0x2::vec_map::get_mut<IDEquipo, Equipo>(&mut arg2.equipos, &v0).jugadores, &v1);
    }

    public fun eliminar_liga(arg0: Liga) {
        let Liga {
            id      : v0,
            nombre  : _,
            equipos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

