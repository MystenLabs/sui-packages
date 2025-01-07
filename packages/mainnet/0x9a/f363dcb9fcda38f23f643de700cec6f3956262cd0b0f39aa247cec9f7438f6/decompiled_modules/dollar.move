module 0x9af363dcb9fcda38f23f643de700cec6f3956262cd0b0f39aa247cec9f7438f6::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 6, b"Dollar", b"$1", b"$1 is the first decentralized stablecoin on Sui. However, it is currently depegged. It's simple. We just need to repeg it to $1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/one_064cee5bd8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

