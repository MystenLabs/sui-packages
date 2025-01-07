module 0x89ce9f242c4415149b3c4e064686685e5b1c580d8dee2452cf9bbaed12af27b4::peng {
    struct PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENG>(arg0, 6, b"PENG", b"Peng Sui", b"Sliding into battle, waddling out with victory $PENG  will never surrender!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bca738cd_42a3_4152_8a37_cf4a9662eb01_604c14c180.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

