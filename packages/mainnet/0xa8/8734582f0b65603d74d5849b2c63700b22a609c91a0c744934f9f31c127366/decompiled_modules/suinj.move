module 0xa88734582f0b65603d74d5849b2c63700b22a609c91a0c744934f9f31c127366::suinj {
    struct SUINJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINJ>(arg0, 6, b"SUINJ", b"Suinj on sui", b"How is your cryptos going lately ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_d_A_cran_2024_09_24_014217_67f5354248.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

