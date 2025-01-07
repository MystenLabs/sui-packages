module 0x8822b27be6fc3cc9e851f59cc7a5f14c4297327c631717223c83da00f5c41fb0::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"SUI PANDA", b"World's Cutest Panda Embraces Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PANDASUI_05109d3190.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

