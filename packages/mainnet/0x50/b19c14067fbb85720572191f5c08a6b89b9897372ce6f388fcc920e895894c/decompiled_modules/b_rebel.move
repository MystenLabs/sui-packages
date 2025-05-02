module 0x50b19c14067fbb85720572191f5c08a6b89b9897372ce6f388fcc920e895894c::b_rebel {
    struct B_REBEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_REBEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_REBEL>(arg0, 9, b"bREBEL", b"bToken REBEL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_REBEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_REBEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

