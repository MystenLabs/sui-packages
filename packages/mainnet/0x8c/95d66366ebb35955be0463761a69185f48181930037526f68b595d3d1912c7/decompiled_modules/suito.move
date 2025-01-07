module 0x8c95d66366ebb35955be0463761a69185f48181930037526f68b595d3d1912c7::suito {
    struct SUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITO>(arg0, 6, b"SUITO", b"SUITO SHARK", b"SUITO is the official funny shark on SUI who loves to have a drink or two.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suito_ee121cb940.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

