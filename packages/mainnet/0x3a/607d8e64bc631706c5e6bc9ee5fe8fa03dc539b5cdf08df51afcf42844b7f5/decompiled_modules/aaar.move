module 0x3a607d8e64bc631706c5e6bc9ee5fe8fa03dc539b5cdf08df51afcf42844b7f5::aaar {
    struct AAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAR>(arg0, 6, b"AAAR", b"AAAARAT ON SUI", b"Can't stop won't stop (thinking about Sui)(real AAAAAAAAAAAAAAAAAAAAAARAT)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_efc92e6a42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

