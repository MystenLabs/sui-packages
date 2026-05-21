module 0x6e5db35cd51333a546984b6d568fdcdb33dcbdea127a100d3ccaa88935519ec7::b_peeka {
    struct B_PEEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PEEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PEEKA>(arg0, 9, b"bPEEKA", b"bToken PEEKA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PEEKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PEEKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

