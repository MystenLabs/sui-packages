module 0xac31f2acf02aa2c3f60c9be97518abf1ecfdb422b823e9353a397ad0d568cdc5::gowoat {
    struct GOWOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOWOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOWOAT>(arg0, 6, b"GOWOAT", x"474f574f4154206f6e2053756920f09f9090", x"24474f574f41542069732074686520756c74696d617465206d656d6520636f696e206f6e207468652053554920626c6f636b636861696e207468617420656d626f646965732074686520737069726974206f662074686520474f4154e28094546865204772656174657374206f6620416c6c2054696d652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730976603888.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOWOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOWOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

