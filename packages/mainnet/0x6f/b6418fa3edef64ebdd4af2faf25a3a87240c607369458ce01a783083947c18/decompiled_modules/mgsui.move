module 0x6fb6418fa3edef64ebdd4af2faf25a3a87240c607369458ce01a783083947c18::mgsui {
    struct MGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGSUI>(arg0, 9, b"MGSui", b"MineGram", b"MGSui is the native token of the MineGram Application. A virtual mining app on telegram. @mine_gram_bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/dpm4MmL/logotoken.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MGSUI>(&mut v2, 25000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

