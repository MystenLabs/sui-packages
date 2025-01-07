module 0xa0e84d70b9d5c7ad5d8c1f1f882ca32d63e14c9cf714ee75e0ba0694b9c869c4::thatlittlepuff {
    struct THATLITTLEPUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: THATLITTLEPUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THATLITTLEPUFF>(arg0, 6, b"Thatlittlepuff", b"1st cat on internet", x"31737420706f70756c617220636174206f6e20696e7465726e6574203c33203c33203c330a68747470733a2f2f7777772e796f75747562652e636f6d2f40546861744c6974746c6550756666", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jy_w_F1_A_400x400_cacb99160f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THATLITTLEPUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THATLITTLEPUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

