module 0x7e222b353cd4bb33de78538c70d6b8849bbbb415b41cf7b9a5a4e0490fb53486::whalebert {
    struct WHALEBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALEBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALEBERT>(arg0, 9, b"WHALEBERT", b"WHALEBERT", b"Blub, I'm going to be the biggest meme on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9uhHjyfc5tKdaZnjstLLKoLGcF889ub8zX9wtwhtzgK6.png?size=lg&key=f8df82")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALEBERT>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALEBERT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALEBERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

