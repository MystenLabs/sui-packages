module 0x19aae3d78bb3a1a660b4602ece812c6c2b315d9fa852ea77af5d231348f80eb7::start {
    struct START has drop {
        dummy_field: bool,
    }

    fun init(arg0: START, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<START>(arg0, 6, b"START", b"The game has begun", b"The game has begun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_pantalla_2024_12_26_225121_1a7192d2f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<START>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<START>>(v1);
    }

    // decompiled from Move bytecode v6
}

