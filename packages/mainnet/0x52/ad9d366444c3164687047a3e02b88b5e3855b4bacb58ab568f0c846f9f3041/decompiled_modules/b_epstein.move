module 0x52ad9d366444c3164687047a3e02b88b5e3855b4bacb58ab568f0c846f9f3041::b_epstein {
    struct B_EPSTEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EPSTEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EPSTEIN>(arg0, 9, b"bEPSTEIN", b"bToken EPSTEIN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EPSTEIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EPSTEIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

