module 0x3dc6da5611272eb441667557de0f7a51e5218eee209b773ee6306f0d9cd6ef75::suizi {
    struct SUIZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZI>(arg0, 6, b"SUIZI", b"Suizi the owl", b"Cheer for fun with no emotions on Sui like a maniac!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_M_Jmj9_y_400x400_ce23c48e9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

