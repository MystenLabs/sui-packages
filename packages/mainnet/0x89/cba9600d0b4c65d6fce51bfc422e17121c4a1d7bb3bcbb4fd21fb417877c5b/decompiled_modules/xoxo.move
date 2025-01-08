module 0x89cba9600d0b4c65d6fce51bfc422e17121c4a1d7bb3bcbb4fd21fb417877c5b::xoxo {
    struct XOXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XOXO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XOXO>(arg0, 6, b"XOXO", b"XOXO AI by SuiAI", b"Transform your dating life with XOXO - Your personal AI matchmaker that turns digital connections into real-world romance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/XOXO_Logo_f1f70b68f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XOXO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XOXO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

