module 0x3486c31f360ad8536dc001a4e7d31f0ea1d648403645dc5cb2b5e3bf3bacbb05::playlist {
    struct Playlist has store, key {
        id: 0x2::object::UID,
        dueno: address,
        canciones: 0x2::vec_map::VecMap<0x1::string::String, Propiedades>,
    }

    struct Propiedades has copy, drop, store {
        duracion: u16,
        cantante: 0x1::string::String,
        ano_publicacion: u8,
        album: 0x1::string::String,
    }

    public fun agregar_cancion(arg0: &mut Playlist, arg1: 0x1::string::String, arg2: u16, arg3: 0x1::string::String, arg4: u8, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Propiedades{
            duracion        : arg2,
            cantante        : arg3,
            ano_publicacion : arg4,
            album           : arg5,
        };
        assert!(arg0.dueno == 0x2::tx_context::sender(arg6), 13906834346142072833);
        0x2::vec_map::insert<0x1::string::String, Propiedades>(&mut arg0.canciones, arg1, v0);
    }

    public fun borrar_cancion(arg0: &mut Playlist, arg1: 0x1::string::String) {
        assert!(0x2::vec_map::contains<0x1::string::String, Propiedades>(&arg0.canciones, &arg1), 13906834376206974979);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, Propiedades>(&mut arg0.canciones, &arg1);
    }

    public fun crear_playlist(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Playlist{
            id        : 0x2::object::new(arg0),
            dueno     : 0x2::tx_context::sender(arg0),
            canciones : 0x2::vec_map::empty<0x1::string::String, Propiedades>(),
        };
        0x2::transfer::transfer<Playlist>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_playlist(arg0: Playlist) {
        let Playlist {
            id        : v0,
            dueno     : _,
            canciones : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

