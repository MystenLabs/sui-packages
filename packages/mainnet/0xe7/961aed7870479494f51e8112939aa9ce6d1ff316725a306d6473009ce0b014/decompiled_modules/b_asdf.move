module 0xe7961aed7870479494f51e8112939aa9ce6d1ff316725a306d6473009ce0b014::b_asdf {
    struct B_ASDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ASDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ASDF>(arg0, 9, b"bASDF", b"bToken ASDF", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ASDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ASDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

