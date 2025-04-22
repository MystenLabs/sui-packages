module 0x49a33e371754423e97a46b84e1c93b8e99a7d289e61363e6bed4a5b9f3e23bf5::zxf {
    struct ZXF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXF>(arg0, 9, b"ZXF", b"zcxvz", b"dafsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZXF>>(v1);
    }

    // decompiled from Move bytecode v6
}

