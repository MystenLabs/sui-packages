module 0x79c5486e05caea706aab4b5dfcf7ec698289822b891ec2d29d4a75de0f1b864f::acortador_urls {
    struct SistemaAcortador has key {
        id: 0x2::object::UID,
        propietario: address,
        urls: 0x2::table::Table<0x1::string::String, UrlAcortada>,
        total_urls: u64,
        total_clicks: u64,
    }

    struct UrlAcortada has store {
        url_original: 0x1::string::String,
        codigo: 0x1::string::String,
        clicks: u64,
        activa: bool,
        fecha_creacion: u64,
        caducidad: u64,
    }

    public fun acortar_url(arg0: &mut SistemaAcortador, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        let v0 = 0x1::string::utf8(arg2);
        let v1 = UrlAcortada{
            url_original   : 0x1::string::utf8(arg1),
            codigo         : v0,
            clicks         : 0,
            activa         : true,
            fecha_creacion : 0,
            caducidad      : arg3,
        };
        0x2::table::add<0x1::string::String, UrlAcortada>(&mut arg0.urls, v0, v1);
        arg0.total_urls = arg0.total_urls + 1;
    }

    public fun crear_sistema(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SistemaAcortador{
            id           : 0x2::object::new(arg0),
            propietario  : 0x2::tx_context::sender(arg0),
            urls         : 0x2::table::new<0x1::string::String, UrlAcortada>(arg0),
            total_urls   : 0,
            total_clicks : 0,
        };
        0x2::transfer::share_object<SistemaAcortador>(v0);
    }

    public fun desactivar_url(arg0: &mut SistemaAcortador, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.propietario == 0x2::tx_context::sender(arg2), 1);
        0x2::table::borrow_mut<0x1::string::String, UrlAcortada>(&mut arg0.urls, 0x1::string::utf8(arg1)).activa = false;
    }

    public fun obtener_clicks(arg0: &SistemaAcortador, arg1: vector<u8>) : u64 {
        0x2::table::borrow<0x1::string::String, UrlAcortada>(&arg0.urls, 0x1::string::utf8(arg1)).clicks
    }

    public fun registrar_click(arg0: &mut SistemaAcortador, arg1: vector<u8>) {
        let v0 = 0x2::table::borrow_mut<0x1::string::String, UrlAcortada>(&mut arg0.urls, 0x1::string::utf8(arg1));
        if (v0.activa) {
            v0.clicks = v0.clicks + 1;
            arg0.total_clicks = arg0.total_clicks + 1;
        };
    }

    // decompiled from Move bytecode v6
}

