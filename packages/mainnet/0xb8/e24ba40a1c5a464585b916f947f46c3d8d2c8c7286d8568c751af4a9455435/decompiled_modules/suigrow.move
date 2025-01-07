module 0xb8e24ba40a1c5a464585b916f947f46c3d8d2c8c7286d8568c751af4a9455435::suigrow {
    struct SUIGROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGROW>(arg0, 6, b"SUIGROW", b"SuiTreeGrow", b"The Money Tree on Sui - SuiTreeGrow $SUIGROW.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_11_02_18_0377f9399c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

