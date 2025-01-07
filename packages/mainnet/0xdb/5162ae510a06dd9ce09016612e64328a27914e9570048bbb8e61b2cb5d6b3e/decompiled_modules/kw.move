module 0xdb5162ae510a06dd9ce09016612e64328a27914e9570048bbb8e61b2cb5d6b3e::kw {
    struct KW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KW>(arg0, 9, b"KW", b"GBCMOBILE", b"GBC is the first Arab pioneering company to innovate in the field of providing services", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gbcmobile.com/en/")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KW>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KW>>(v1);
    }

    // decompiled from Move bytecode v6
}

