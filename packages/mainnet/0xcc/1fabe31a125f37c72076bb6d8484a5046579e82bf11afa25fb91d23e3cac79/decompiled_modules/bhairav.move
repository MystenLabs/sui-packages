module 0xcc1fabe31a125f37c72076bb6d8484a5046579e82bf11afa25fb91d23e3cac79::bhairav {
    struct BHAIRAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHAIRAV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BHAIRAV>(arg0, 6, b"BHAIRAV", b"Bhairav by SuiAI", b"$BHAIRAV is a fierce and powerful meme coin inspired by the intense manifestation of Lord Shiva - Bhairava, the cosmic protector and destroyer of obstacles. This token embodies the raw, transformative energy of Bhairava, promising to be the ultimate 'fear destroyer' in the crypto markets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004094_8f7df6c01e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BHAIRAV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHAIRAV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

