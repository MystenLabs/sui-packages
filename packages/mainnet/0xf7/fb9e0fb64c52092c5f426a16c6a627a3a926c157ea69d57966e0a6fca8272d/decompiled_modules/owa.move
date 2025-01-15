module 0xf7fb9e0fb64c52092c5f426a16c6a627a3a926c157ea69d57966e0a6fca8272d::owa {
    struct OWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWA>(arg0, 6, b"OWA", b"One Word Agent", b"One word is enough.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/owa75_5a424b97e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

