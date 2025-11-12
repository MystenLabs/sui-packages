module 0x1b920743c4a2eeb81ea1776f73b6768f765a5140c48d4367ed335c325a1b03e::apiario_virtual {
    struct Apiario has key {
        id: 0x2::object::UID,
        apicultor: address,
        colmenas: 0x2::table::Table<u64, Colmena>,
        cosechas: 0x2::table::Table<u64, Cosecha>,
        contador_colmenas: u64,
        contador_cosechas: u64,
    }

    struct Colmena has store {
        id: u64,
        ubicacion: 0x1::string::String,
        poblacion_abejas: u64,
        salud_reina: u8,
        produccion_diaria: u64,
        temperatura: u64,
        activa: bool,
        dias_activos: u64,
    }

    struct Cosecha has store {
        id: u64,
        colmena_id: u64,
        kilos_miel: u64,
        calidad: u8,
        fecha: u64,
        tipo_flor: 0x1::string::String,
        vendida: bool,
    }

    public fun actualizar_colmena(arg0: &mut Apiario, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.apicultor == 0x2::tx_context::sender(arg4), 1);
        let v0 = 0x2::table::borrow_mut<u64, Colmena>(&mut arg0.colmenas, arg1);
        v0.poblacion_abejas = arg2;
        v0.temperatura = arg3;
        v0.produccion_diaria = arg2 / 1000;
        v0.dias_activos = v0.dias_activos + 1;
    }

    public fun cosechar_miel(arg0: &mut Apiario, arg1: u64, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.apicultor == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::table::borrow<u64, Colmena>(&arg0.colmenas, arg1).activa, 2);
        let v0 = Cosecha{
            id         : arg0.contador_cosechas,
            colmena_id : arg1,
            kilos_miel : arg2,
            calidad    : arg3,
            fecha      : 0,
            tipo_flor  : 0x1::string::utf8(arg4),
            vendida    : false,
        };
        0x2::table::add<u64, Cosecha>(&mut arg0.cosechas, arg0.contador_cosechas, v0);
        arg0.contador_cosechas = arg0.contador_cosechas + 1;
    }

    public fun crear_apiario(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Apiario{
            id                : 0x2::object::new(arg0),
            apicultor         : 0x2::tx_context::sender(arg0),
            colmenas          : 0x2::table::new<u64, Colmena>(arg0),
            cosechas          : 0x2::table::new<u64, Cosecha>(arg0),
            contador_colmenas : 0,
            contador_cosechas : 0,
        };
        0x2::transfer::share_object<Apiario>(v0);
    }

    public fun instalar_colmena(arg0: &mut Apiario, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.apicultor == 0x2::tx_context::sender(arg3), 1);
        let v0 = Colmena{
            id                : arg0.contador_colmenas,
            ubicacion         : 0x1::string::utf8(arg1),
            poblacion_abejas  : arg2,
            salud_reina       : 100,
            produccion_diaria : arg2 / 1000,
            temperatura       : 35,
            activa            : true,
            dias_activos      : 0,
        };
        0x2::table::add<u64, Colmena>(&mut arg0.colmenas, arg0.contador_colmenas, v0);
        arg0.contador_colmenas = arg0.contador_colmenas + 1;
    }

    public fun vender_cosecha(arg0: &mut Apiario, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.apicultor == 0x2::tx_context::sender(arg2), 1);
        0x2::table::borrow_mut<u64, Cosecha>(&mut arg0.cosechas, arg1).vendida = true;
    }

    // decompiled from Move bytecode v6
}

