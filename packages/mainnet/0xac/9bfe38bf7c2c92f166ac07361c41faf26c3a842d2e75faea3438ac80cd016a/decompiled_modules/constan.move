module 0xac9bfe38bf7c2c92f166ac07361c41faf26c3a842d2e75faea3438ac80cd016a::constan {
    struct CONSTAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONSTAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CONSTAN>(arg0, 6, b"CONSTAN", b"Constantine by SuiAI", b"He's an expert sorcerer and magician, but also an accomplished liar and thief known for his vices, self-loathing and on-again-off-again death wish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/keanu_reeves_309af12984.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CONSTAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONSTAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

