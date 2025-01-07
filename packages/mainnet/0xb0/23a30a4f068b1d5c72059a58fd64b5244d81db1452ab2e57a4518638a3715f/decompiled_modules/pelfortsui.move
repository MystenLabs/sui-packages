module 0xb023a30a4f068b1d5c72059a58fd64b5244d81db1452ab2e57a4518638a3715f::pelfortsui {
    struct PELFORTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELFORTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELFORTSUI>(arg0, 6, b"PELFORTSUI", b"First The Wolf of Sui", b"Dexscreener Paid.Check here: https://www.pelfortsui.lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_10_4160e02c7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELFORTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELFORTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

