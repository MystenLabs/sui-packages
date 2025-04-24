module 0x62262519ae58e88e8d0c92ce15201af58d64eaae4b6ec4ed9853d43cc6c665dc::zzd {
    struct ZZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZD>(arg0, 9, b"ZZD", b"zzzd", b"asdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZD>>(v1);
    }

    // decompiled from Move bytecode v6
}

