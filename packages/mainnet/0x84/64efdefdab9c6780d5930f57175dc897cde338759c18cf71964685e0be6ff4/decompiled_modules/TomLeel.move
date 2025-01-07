module 0x8464efdefdab9c6780d5930f57175dc897cde338759c18cf71964685e0be6ff4::TomLeel {
    struct TOMLEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMLEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMLEEL>(arg0, 6, b"TomLeel", b"TomLeel made by Tom", b"TomLeel made by Tom", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMLEEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMLEEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

