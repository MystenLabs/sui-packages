module 0xd33ff7912eea2548769fd8953ac9c989407e1d83c58e05ca1fa851f4d3deea68::aaawfog {
    struct AAAWFOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAWFOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAWFOG>(arg0, 6, b"AAAWFOG", b"aaaFWOG", b"can't stop won't stop (talking about SUI)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaafweog_082e5d4547.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAWFOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAWFOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

