module 0xc8dbc77c528e4cad9e7a83584df5babe07ff304e225f8ea0fd982e2821273405::cardi {
    struct CARDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARDI>(arg0, 6, b"Cardi", b"Wet Ass Pussy", b"Cardi and her pussy just went live onchain , but not on Only fan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1936_e0deee1b5b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

