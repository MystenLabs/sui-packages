module 0x9b3bcd1c82990c8bed257bf9255e20a5026d2310656e87c4ee7c112f61402390::b_testing {
    struct B_TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TESTING>(arg0, 9, b"bTESTING", b"bToken TESTING", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TESTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TESTING>>(v1);
    }

    // decompiled from Move bytecode v6
}

