module 0x6a8dca5aa52adfc07c73596608913e3b28a2bc2fcabe60360b1937e9ee676e15::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SUISUPA", x"4f757220706c616e21204166746572206c61756e63680a0a4275726e204275726e204275726e200a5570706572205570706572205570706572200a54686174206d65616e7320436f6f6b696e6720666f7220486f646c6572732121200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018186_64c6d3cdee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

