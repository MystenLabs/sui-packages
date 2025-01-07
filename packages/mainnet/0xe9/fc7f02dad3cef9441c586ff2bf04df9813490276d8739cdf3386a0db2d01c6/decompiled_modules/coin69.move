module 0xe9fc7f02dad3cef9441c586ff2bf04df9813490276d8739cdf3386a0db2d01c6::coin69 {
    struct COIN69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN69>(arg0, 6, b"COIN69", b"COIN6900 sui", b"COIN6900", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C_Hn1_R6d3_400x400_46c0785890.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COIN69>>(v1);
    }

    // decompiled from Move bytecode v6
}

