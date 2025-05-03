module 0x6a95b95a3006d98123dd5e6a8f09fe4da9f26688191eadedd1f72ceb870dfede::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 9, b"GROK", b"New XAI gork", b"Join us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/38PgzpJYu2HkiYvV8qePFakB8tuobPdGm2FFEn7Dpump.png?size=xl&key=38a3f0")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GROK>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

