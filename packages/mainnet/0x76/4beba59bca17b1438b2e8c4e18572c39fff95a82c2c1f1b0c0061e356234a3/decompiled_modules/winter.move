module 0x764beba59bca17b1438b2e8c4e18572c39fff95a82c2c1f1b0c0061e356234a3::winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 6, b"WINTER", b"Winter Bear on Sui", b"ONE AND ONLY WINTER BEAR ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/649f282f_0c2c_4298_9d02_17c3aa459d08_ec8567520a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

