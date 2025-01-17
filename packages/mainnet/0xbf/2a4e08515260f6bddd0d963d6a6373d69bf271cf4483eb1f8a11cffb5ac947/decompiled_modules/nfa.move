module 0xbf2a4e08515260f6bddd0d963d6a6373d69bf271cf4483eb1f8a11cffb5ac947::nfa {
    struct NFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFA>(arg0, 6, b"NFA", b"Not financial Advice", x"54727920796f7572206c75636b210a0a2d204c70204275726e6564200a2d204e6f2066616b65207368697473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737096092238.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

