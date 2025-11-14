module 0x609bf9d0e3ecfc772ab6863655a98c77bdd19cb80b5455b02f18245131acf711::red_social {
    struct Usuario has key {
        id: 0x2::object::UID,
        owner: address,
        nombre_usuario: 0x1::string::String,
        publicaciones: 0x2::vec_map::VecMap<u64, Publicacion>,
    }

    struct Publicacion has store {
        titulo: 0x1::string::String,
        descripcion: 0x1::string::String,
        comentarios: 0x2::vec_map::VecMap<u16, Comentario>,
        archivo_id: 0x2::object::ID,
    }

    struct Comentario has copy, drop, store {
        nombre_usuario: 0x1::string::String,
        contenido: 0x1::string::String,
    }

    struct PublicacionCreada has copy, drop, store {
        usuario: 0x2::object::ID,
        id_pub: u64,
        archivo_id: 0x2::object::ID,
    }

    struct ComentarioSubido has copy, drop, store {
        usuario: 0x2::object::ID,
        id_pub: u64,
        id_comentario: u16,
    }

    public fun crear_publicacion(arg0: &mut Usuario, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 13906834509351223303);
        assert!(!0x2::vec_map::contains<u64, Publicacion>(&arg0.publicaciones, &arg1), 13906834513645797377);
        assert!(0x1::string::length(&arg2) > 0, 13906834517941026821);
        assert!(0x1::string::length(&arg3) > 0, 13906834522235994117);
        let v0 = Publicacion{
            titulo      : arg2,
            descripcion : arg3,
            comentarios : 0x2::vec_map::empty<u16, Comentario>(),
            archivo_id  : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg4),
        };
        0x2::vec_map::insert<u64, Publicacion>(&mut arg0.publicaciones, arg1, v0);
        let v1 = PublicacionCreada{
            usuario    : *0x2::object::uid_as_inner(&arg0.id),
            id_pub     : arg1,
            archivo_id : 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg4),
        };
        0x2::event::emit<PublicacionCreada>(v1);
    }

    public fun crear_usuario(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 13906834427746713605);
        let v0 = Usuario{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            nombre_usuario : arg0,
            publicaciones  : 0x2::vec_map::empty<u64, Publicacion>(),
        };
        0x2::transfer::transfer<Usuario>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun subir_comentario(arg0: &mut Usuario, arg1: u64, arg2: u16, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 13906834621020372999);
        assert!(0x2::vec_map::contains<u64, Publicacion>(&arg0.publicaciones, &arg1), 13906834633905012739);
        let v0 = 0x2::vec_map::get_mut<u64, Publicacion>(&mut arg0.publicaciones, &arg1);
        assert!(!0x2::vec_map::contains<u16, Comentario>(&v0.comentarios, &arg2), 13906834646789783553);
        assert!(0x1::string::length(&arg3) > 0, 13906834651085012997);
        assert!(0x1::string::length(&arg4) > 0, 13906834655379980293);
        let v1 = Comentario{
            nombre_usuario : arg3,
            contenido      : arg4,
        };
        0x2::vec_map::insert<u16, Comentario>(&mut v0.comentarios, arg2, v1);
        let v2 = ComentarioSubido{
            usuario       : *0x2::object::uid_as_inner(&arg0.id),
            id_pub        : arg1,
            id_comentario : arg2,
        };
        0x2::event::emit<ComentarioSubido>(v2);
    }

    // decompiled from Move bytecode v6
}

