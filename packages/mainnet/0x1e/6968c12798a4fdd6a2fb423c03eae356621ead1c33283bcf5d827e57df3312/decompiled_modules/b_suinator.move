module 0x1e6968c12798a4fdd6a2fb423c03eae356621ead1c33283bcf5d827e57df3312::b_suinator {
    struct B_SUINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUINATOR>(arg0, 9, b"bSUINATOR", b"bToken SUINATOR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUINATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUINATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

