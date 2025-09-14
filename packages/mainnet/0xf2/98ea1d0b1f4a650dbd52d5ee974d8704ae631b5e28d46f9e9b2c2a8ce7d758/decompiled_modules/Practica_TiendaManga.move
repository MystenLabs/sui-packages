module 0xf298ea1d0b1f4a650dbd52d5ee974d8704ae631b5e28d46f9e9b2c2a8ce7d758::Practica_TiendaManga {
    struct Tienda has store, key {
        id: 0x2::object::UID,
        nombre_Tienda: 0x1::string::String,
        mangas: 0x2::vec_map::VecMap<u64, Manga>,
    }

    struct Manga has copy, drop, store {
        nombre: 0x1::string::String,
        fecha_publicacion: u16,
        autor: 0x1::string::String,
        genero: 0x1::string::String,
    }

    public fun agregar_manga(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String, arg3: u16, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        assert!(!0x2::vec_map::contains<u64, Manga>(&arg0.mangas, &arg1), 1);
        let v0 = Manga{
            nombre            : arg2,
            fecha_publicacion : arg3,
            autor             : arg4,
            genero            : arg5,
        };
        0x2::vec_map::insert<u64, Manga>(&mut arg0.mangas, arg1, v0);
    }

    public fun crear_Tienda(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Tienda{
            id            : 0x2::object::new(arg1),
            nombre_Tienda : arg0,
            mangas        : 0x2::vec_map::empty<u64, Manga>(),
        };
        0x2::transfer::transfer<Tienda>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun eliminar_manga(arg0: &mut Tienda, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Manga>(&arg0.mangas, &arg1), 2);
        let (_, _) = 0x2::vec_map::remove<u64, Manga>(&mut arg0.mangas, &arg1);
    }

    public fun modificar_autor(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Manga>(&arg0.mangas, &arg1), 2);
        0x2::vec_map::get_mut<u64, Manga>(&mut arg0.mangas, &arg1).autor = arg2;
    }

    public fun modificar_nombre(arg0: &mut Tienda, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Manga>(&arg0.mangas, &arg1), 2);
        0x2::vec_map::get_mut<u64, Manga>(&mut arg0.mangas, &arg1).nombre = arg2;
    }

    // decompiled from Move bytecode v6
}

