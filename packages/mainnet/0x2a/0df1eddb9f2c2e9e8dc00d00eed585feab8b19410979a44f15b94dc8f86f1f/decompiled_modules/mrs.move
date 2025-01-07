module 0x2a0df1eddb9f2c2e9e8dc00d00eed585feab8b19410979a44f15b94dc8f86f1f::mrs {
    struct MRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRS>(arg0, 6, b"MRS", b"Maximus Rhino Suidius", x"4d6178696d7573205268696e6f2053756964697573203e204d6178696d757320446563696d7573204d657269646975730a0a244d525320546865205374726f6e6765737420476c61646961746f72206f662053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5796430216086798835_5f7096e328.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

