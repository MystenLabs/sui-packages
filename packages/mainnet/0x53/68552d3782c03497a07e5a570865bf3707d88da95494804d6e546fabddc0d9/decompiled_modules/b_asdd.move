module 0x5368552d3782c03497a07e5a570865bf3707d88da95494804d6e546fabddc0d9::b_asdd {
    struct B_ASDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ASDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ASDD>(arg0, 9, b"bASDD", b"bToken ASDD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ASDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ASDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

