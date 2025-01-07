module 0x22ddfddc6229f20f14eb587cc27a9815b4e626c485fb02abfaf087333a1827da::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 8, b"GME", b"Wrapped Coin for Gamestop Inc.", b"Sudo Wrapped Coin for Gamestop", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GME>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GME>>(v0);
    }

    // decompiled from Move bytecode v6
}

