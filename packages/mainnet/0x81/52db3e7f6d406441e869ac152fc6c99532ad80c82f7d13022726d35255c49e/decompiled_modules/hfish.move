module 0x8152db3e7f6d406441e869ac152fc6c99532ad80c82f7d13022726d35255c49e::hfish {
    struct HFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFISH>(arg0, 6, b"HFISH", b"Hop Fish", b"The only fish that can jump. Exclusively on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GYRE_FIWAAA_4_Ke_Q_3f0693e6d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

