module 0xfde0eceae25d78acf3d042a86e8b3c68573b19a257c4a5d2548608db48fbba31::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 9, b"KM", b"Kekius Maximus", b"Let the games begin by SUI Foundation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HuAncxDEsakCDgZS2Yfo9xJbHmtHXMnxxkT9jqdXnHhm.png?size=lg&key=45e8f2")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KM>>(0x2::coin::mint<KM>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KM>>(v2);
    }

    // decompiled from Move bytecode v6
}

