module 0x99693fc70eba2e72c33e71642f38c7763c0cc1aafcbccaacb6858ed1f8f2ffbe::b_rat {
    struct B_RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_RAT>(arg0, 9, b"bRAT", b"bToken RAT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_RAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

