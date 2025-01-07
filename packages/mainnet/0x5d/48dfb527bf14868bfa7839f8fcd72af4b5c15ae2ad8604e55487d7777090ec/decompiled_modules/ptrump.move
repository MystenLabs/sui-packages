module 0x5d48dfb527bf14868bfa7839f8fcd72af4b5c15ae2ad8604e55487d7777090ec::ptrump {
    struct PTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRUMP>(arg0, 9, b"pTRUMP", b"Pepe Trump", b"Make meme coins great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xb8c150fffb0883780107c9e46409e9207a6204a2.png?size=lg&key=0ec0f8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PTRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

