module 0x2a91762971c920f138b1b6b51b573065cb2004c19ffe74b2062516571d099dad::plop {
    struct PLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOP>(arg0, 6, b"PLOP", b"SUI Plop", b"Official Mascot of $SUI chain  plop plop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Plop_1e178de8af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

