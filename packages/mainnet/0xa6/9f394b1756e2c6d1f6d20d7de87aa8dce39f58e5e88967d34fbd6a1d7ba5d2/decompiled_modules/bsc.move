module 0xa69f394b1756e2c6d1f6d20d7de87aa8dce39f58e5e88967d34fbd6a1d7ba5d2::bsc {
    struct BSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSC>(arg0, 6, b"BSC", b"bstcoin", b"https://x.com/thisbistcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_GA_rsel_2024_10_18_saat_16_01_23_54f07ee1_4300abace2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

