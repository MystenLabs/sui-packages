module 0xbb7bd4b6337761e1d96710eadee1d33285f4dfb6659a28d2aea85fb704841b38::wpnut {
    struct WPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPNUT>(arg0, 6, b"WPNUT", b"WIF PNUT", b"Join the nutty revolution with $WPNUT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731766881845.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

