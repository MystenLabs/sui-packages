module 0xfeb56929f5b13e545636754b650104fed68d279118a6b6b6bc74997618a08d7b::walls {
    struct WALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLS>(arg0, 6, b"WALLS", b"Wall sui Boys", b"Wolf of wall street alphas here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029183_0be5ccf1c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

