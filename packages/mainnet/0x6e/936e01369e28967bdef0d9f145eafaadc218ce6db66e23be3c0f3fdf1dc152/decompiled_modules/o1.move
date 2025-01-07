module 0x6e936e01369e28967bdef0d9f145eafaadc218ce6db66e23be3c0f3fdf1dc152::o1 {
    struct O1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: O1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O1>(arg0, 6, b"O1", b"1", b"1 sui and a dream", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Weppy_563ac5fd3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<O1>>(v1);
    }

    // decompiled from Move bytecode v6
}

