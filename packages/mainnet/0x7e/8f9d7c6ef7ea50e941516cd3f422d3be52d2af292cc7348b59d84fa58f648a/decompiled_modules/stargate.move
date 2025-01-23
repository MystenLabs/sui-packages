module 0x7e8f9d7c6ef7ea50e941516cd3f422d3be52d2af292cc7348b59d84fa58f648a::stargate {
    struct STARGATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARGATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARGATE>(arg0, 9, b"Stargate", b"Stargate AI", b"A fun meme about the famous story of Donald Trump launching a meme coin and the flood of copycat accounts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSr3BX9ZTbr4udDubEkRwnhdgDK1nekCkShutJmNpyNJC")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STARGATE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STARGATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARGATE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

