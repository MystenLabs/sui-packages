module 0x6b1b2c613cdb11ab66094254dbcb616bba32b066b40b433b6c67c9c8fdccc52e::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD>(arg0, 9, b"USDsui", b"USDsui", b"A Native Stablecoin for the Sui Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_99_d5297c248f.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USD>>(0x2::coin::mint<USD>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USD>>(v2);
    }

    // decompiled from Move bytecode v6
}

