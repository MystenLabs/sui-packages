module 0x43c771e064a7232e7759af89ca739aef8c2f94001ad0622af70e828eb9c51205::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"BABYTRUMP", b"baby trump by SuiAI", b"baby trump goes to the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6812_81af917be2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYTRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

