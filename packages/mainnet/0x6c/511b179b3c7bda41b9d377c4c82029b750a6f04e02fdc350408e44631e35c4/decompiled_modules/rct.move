module 0x6c511b179b3c7bda41b9d377c4c82029b750a6f04e02fdc350408e44631e35c4::rct {
    struct RCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCT>(arg0, 6, b"RCT", b"rocket sui", b"rocket coin to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/space_rocket_coin_vector_19272755_cd354cd470.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

