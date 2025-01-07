module 0x482372aee474a985dbc792ac6f0d0713002fccf0cd375ad2b6f9abc2e5ce0897::aimom {
    struct AIMOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMOM>(arg0, 6, b"AIMoM", b"AI MOM", b"AI Sui mom looking for sui fun not movepump it will die give it another crash then it will go like a slow rug MOM said", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fem_72bf90a43f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

