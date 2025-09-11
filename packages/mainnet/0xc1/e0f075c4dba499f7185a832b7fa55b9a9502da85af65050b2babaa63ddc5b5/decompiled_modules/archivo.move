module 0xc1e0f075c4dba499f7185a832b7fa55b9a9502da85af65050b2babaa63ddc5b5::archivo {
    struct Archivo has store, key {
        id: 0x2::object::UID,
        documentos: 0x2::vec_map::VecMap<u64, Documento>,
    }

    struct Documento has copy, drop, store {
        nombre: 0x1::string::String,
        propietario: 0x1::string::String,
        fecha_creacion: u16,
        activo: bool,
    }

    public fun actualizar_nombre(arg0: &mut Archivo, arg1: u64, arg2: 0x1::string::String) {
        assert!(0x2::vec_map::contains<u64, Documento>(&arg0.documentos, &arg1), 101);
        0x2::vec_map::get_mut<u64, Documento>(&mut arg0.documentos, &arg1).nombre = arg2;
    }

    public fun agregar_documento(arg0: &mut Archivo, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u16, arg5: bool) {
        assert!(!0x2::vec_map::contains<u64, Documento>(&arg0.documentos, &arg1), 100);
        let v0 = Documento{
            nombre         : arg2,
            propietario    : arg3,
            fecha_creacion : arg4,
            activo         : arg5,
        };
        0x2::vec_map::insert<u64, Documento>(&mut arg0.documentos, arg1, v0);
    }

    public fun crear_archivo(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Archivo{
            id         : 0x2::object::new(arg0),
            documentos : 0x2::vec_map::empty<u64, Documento>(),
        };
        0x2::transfer::transfer<Archivo>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun eliminar_archivo(arg0: Archivo) {
        let Archivo {
            id         : v0,
            documentos : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun eliminar_documento(arg0: &mut Archivo, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Documento>(&arg0.documentos, &arg1), 101);
        let (_, _) = 0x2::vec_map::remove<u64, Documento>(&mut arg0.documentos, &arg1);
    }

    // decompiled from Move bytecode v6
}

