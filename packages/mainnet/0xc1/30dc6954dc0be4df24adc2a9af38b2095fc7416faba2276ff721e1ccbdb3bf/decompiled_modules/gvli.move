module 0xc130dc6954dc0be4df24adc2a9af38b2095fc7416faba2276ff721e1ccbdb3bf::gvli {
    struct GVLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GVLI>(arg0, 6, b"GVLI", b"Geeked vs. Locked in", b"Are you geeked or locked in ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6756_1_07dbe29fdc.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GVLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

