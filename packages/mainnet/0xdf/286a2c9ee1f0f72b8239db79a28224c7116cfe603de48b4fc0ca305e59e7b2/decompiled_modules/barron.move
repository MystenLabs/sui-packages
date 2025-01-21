module 0xdf286a2c9ee1f0f72b8239db79a28224c7116cfe603de48b4fc0ca305e59e7b2::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"BARRON", b"Barron Meme  by SuiAI", b"Rumor has it this was launched by Barron himself. Most likely the future President of America and Time Traveler..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737496266598_9b7d624958.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARRON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

