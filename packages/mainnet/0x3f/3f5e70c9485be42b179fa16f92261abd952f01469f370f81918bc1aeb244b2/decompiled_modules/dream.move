module 0x3f3f5e70c9485be42b179fa16f92261abd952f01469f370f81918bc1aeb244b2::dream {
    struct DREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DREAM>(arg0, 6, b"DREAM", b"Crypto Dream by SuiAI", b"We welcome you to the world of crypto, Mr. President.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2025_01_28_21_50_41_64fcfc7c54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DREAM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DREAM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

