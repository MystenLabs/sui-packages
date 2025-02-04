module 0x101d063da0a9de3d9068a3c66f723f546805368f80ad262479ad53d7b0f4a8e7::sk {
    struct SK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SK>(arg0, 6, b"SK", b"SUI KINGDOM", b"welcome to SUI KINGDOM , lets make sui KING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250204_080858_0000_fd3fd211c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SK>>(v1);
    }

    // decompiled from Move bytecode v6
}

