module 0x9219317d5d66f5c89b29467d0be3606906d3beddf8fd6ef9bcd3bb0ccef49f4::b_testing {
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

