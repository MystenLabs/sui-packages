module 0xbb32ddb41c38fa674f858efce6d3f39e6b2cff0a995295381a782943788bab73::sicpos {
    struct SICPOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SICPOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SICPOS>(arg0, 6, b"SICPOS", b"SACHT SICPOS", b"SICPOS ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_093542_850_1ec2b20a07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SICPOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SICPOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

