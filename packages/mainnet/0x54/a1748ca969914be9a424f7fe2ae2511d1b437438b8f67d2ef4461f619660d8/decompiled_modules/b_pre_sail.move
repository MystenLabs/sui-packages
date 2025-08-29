module 0x54a1748ca969914be9a424f7fe2ae2511d1b437438b8f67d2ef4461f619660d8::b_pre_sail {
    struct B_PRE_SAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PRE_SAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PRE_SAIL>(arg0, 9, b"bpreSAIL", b"bToken preSAIL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PRE_SAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PRE_SAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

