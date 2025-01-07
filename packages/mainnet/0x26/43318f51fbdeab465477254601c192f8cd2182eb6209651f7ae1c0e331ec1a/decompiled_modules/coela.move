module 0x2643318f51fbdeab465477254601c192f8cd2182eb6209651f7ae1c0e331ec1a::coela {
    struct COELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COELA>(arg0, 6, b"COELA", b"Coela", b"Coela is at the bottom of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ciera_icon_89f86fb705.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

