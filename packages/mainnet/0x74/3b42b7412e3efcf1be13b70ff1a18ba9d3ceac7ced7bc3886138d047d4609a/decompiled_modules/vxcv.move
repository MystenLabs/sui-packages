module 0x743b42b7412e3efcf1be13b70ff1a18ba9d3ceac7ced7bc3886138d047d4609a::vxcv {
    struct VXCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VXCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VXCV>(arg0, 9, b"VXCV", b"vzcx", b"sadfasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VXCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VXCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

