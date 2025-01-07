module 0xab5efe805d0aa5c7f83e6a23ad56203ac3f7065ae2ace351695502c4c35a2759::chepe {
    struct CHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEPE>(arg0, 6, b"CHEPE", b"Chad pepe", b"Launching in 2 hours", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gc_E9oh_O_Xo_AAB_2_g_b49fde7d39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

