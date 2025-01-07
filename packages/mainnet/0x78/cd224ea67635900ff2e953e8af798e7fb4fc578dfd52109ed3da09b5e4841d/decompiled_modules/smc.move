module 0x78cd224ea67635900ff2e953e8af798e7fb4fc578dfd52109ed3da09b5e4841d::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"Sui Mars City", b"Building Mars City.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_19_21_45_6381c763ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

