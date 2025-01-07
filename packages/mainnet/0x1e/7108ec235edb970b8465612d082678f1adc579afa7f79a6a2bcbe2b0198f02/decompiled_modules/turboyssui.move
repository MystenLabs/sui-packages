module 0x1e7108ec235edb970b8465612d082678f1adc579afa7f79a6a2bcbe2b0198f02::turboyssui {
    struct TURBOYSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOYSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOYSSUI>(arg0, 6, b"TURBOYSSUI", b"Turboyssui", b"TURBOYSSUI: The Ultimate Meme Coin Revolution on the SUI Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731168491653.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOYSSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOYSSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

