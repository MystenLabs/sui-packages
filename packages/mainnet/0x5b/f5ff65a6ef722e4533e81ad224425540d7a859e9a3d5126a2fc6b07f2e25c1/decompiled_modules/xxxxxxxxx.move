module 0x5bf5ff65a6ef722e4533e81ad224425540d7a859e9a3d5126a2fc6b07f2e25c1::xxxxxxxxx {
    struct XXXXXXXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXXXXXXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXXXXXXXX>(arg0, 6, b"XXXXXXXXX", b"XXXXXX", b"XXXXXXXXXXXX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Black_Myth_Wukong_Game_Science_44d39979cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXXXXXXXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXXXXXXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

