module 0x699f7345e6ee5572160f4c0abec5144ec68fe1444dd3a6405d5be295aeafd4ba::b_peng {
    struct B_PENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PENG>(arg0, 9, b"bPENG", b"bToken PENG", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

