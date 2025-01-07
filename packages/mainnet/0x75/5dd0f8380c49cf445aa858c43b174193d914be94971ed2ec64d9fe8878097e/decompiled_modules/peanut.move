module 0x755dd0f8380c49cf445aa858c43b174193d914be94971ed2ec64d9fe8878097e::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEANUT>(arg0, 6, b"PEANUT", b"TURBO PEANUT SQUIRRE", b"Introducing SuiSquirrel Coin: The Freshest MemeCoin in the Game!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990700371.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEANUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

