module 0x6e8f77d2f8e8507af5bad690dbf6f91947809e73e7ea8e2a7ff17dbe5f490dec::trumpsui {
    struct TRUMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSUI>(arg0, 6, b"TRUMPSUI", b"Official Trump SUI", b"This is the official Trump Coin in SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_ZT_6_J_Sql_400x400_3e20a2ccb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

