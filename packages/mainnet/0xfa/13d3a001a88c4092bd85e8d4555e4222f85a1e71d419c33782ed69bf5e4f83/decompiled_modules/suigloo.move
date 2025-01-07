module 0xfa13d3a001a88c4092bd85e8d4555e4222f85a1e71d419c33782ed69bf5e4f83::suigloo {
    struct SUIGLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLOO>(arg0, 6, b"SUIGLOO", b"GLOO On SUI", b"Gloo is the new SUI mascot ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gloo_5e858362d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

