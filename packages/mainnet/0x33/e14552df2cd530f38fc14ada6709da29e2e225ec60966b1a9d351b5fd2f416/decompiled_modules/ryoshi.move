module 0x33e14552df2cd530f38fc14ada6709da29e2e225ec60966b1a9d351b5fd2f416::ryoshi {
    struct RYOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RYOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RYOSHI>(arg0, 6, b"RYOSHI", b"Ryoshi", b"Ryoshi coming into sui, The Shiba Army is here to make a new history and make sui meme flying further ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731157313867.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RYOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RYOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

