module 0x3d303ef22d129cf408514446b3f367768debd23263cafebbcd1d44e9f4243d94::core {
    struct LoteMedicamento has store, key {
        id: 0x2::object::UID,
        serial: 0x1::string::String,
        nombre: 0x1::string::String,
        fabricante: 0x1::string::String,
        fecha_fabricacion: u64,
        fecha_caducidad: u64,
        temperatura_max: u8,
        estado: 0x1::string::String,
        historial: vector<Evento>,
    }

    struct Evento has store {
        timestamp: u64,
        ubicacion: 0x1::string::String,
        responsable: 0x1::string::String,
        temperatura: u8,
    }

    struct Pedido has key {
        id: 0x2::object::UID,
        lote_ids: vector<0x2::object::ID>,
        comprador: address,
        fecha_entrega_esperada: u64,
        entregado: bool,
    }

    public entry fun cambiar_estado(arg0: &mut LoteMedicamento, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Evento{
            timestamp   : 0x2::tx_context::epoch(arg5),
            ubicacion   : arg2,
            responsable : arg3,
            temperatura : arg4,
        };
        0x1::vector::push_back<Evento>(&mut arg0.historial, v0);
        arg0.estado = arg1;
    }

    public entry fun crear_lote(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = LoteMedicamento{
            id                : 0x2::object::new(arg6),
            serial            : arg0,
            nombre            : arg1,
            fabricante        : arg2,
            fecha_fabricacion : arg3,
            fecha_caducidad   : arg4,
            temperatura_max   : arg5,
            estado            : 0x1::string::utf8(b"en_fabrica"),
            historial         : 0x1::vector::empty<Evento>(),
        };
        0x2::transfer::transfer<LoteMedicamento>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun registrar_temperatura(arg0: &mut LoteMedicamento, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.estado == 0x1::string::utf8(b"en_transito"), 0);
    }

    // decompiled from Move bytecode v6
}

