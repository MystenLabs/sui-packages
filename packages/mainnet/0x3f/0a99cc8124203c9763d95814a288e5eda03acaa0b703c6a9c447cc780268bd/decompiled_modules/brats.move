module 0x3f0a99cc8124203c9763d95814a288e5eda03acaa0b703c6a9c447cc780268bd::brats {
    struct BRATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRATS>(arg0, 6, b"BRATS", b"Brat SUImpson", b"Brats say hello to everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_4_8742019bdf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

