module 0x94bde1efb53a6266918296b72d163902397f17e16b370496c50a5722c3ead2ca::brog {
    struct BROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROG>(arg0, 6, b"BROG", b"BrogWogSui", b"Not just coin, Brog it's a culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000063009_2acd8f11f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

