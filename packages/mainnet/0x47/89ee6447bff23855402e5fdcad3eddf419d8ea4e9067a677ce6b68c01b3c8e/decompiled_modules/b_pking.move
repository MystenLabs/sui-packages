module 0x4789ee6447bff23855402e5fdcad3eddf419d8ea4e9067a677ce6b68c01b3c8e::b_pking {
    struct B_PKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PKING>(arg0, 9, b"bPKING", b"bToken PKING", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

