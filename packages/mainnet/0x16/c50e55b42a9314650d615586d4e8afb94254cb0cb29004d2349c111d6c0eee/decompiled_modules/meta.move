module 0x16c50e55b42a9314650d615586d4e8afb94254cb0cb29004d2349c111d6c0eee::meta {
    struct META has drop {
        dummy_field: bool,
    }

    fun init(arg0: META, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<META>(arg0, 9, b"META", b"MAGA ELON AND TRUMP", b"Dark MAGA' movement dreams of a vengeful Trump destroying his enemies, and is using 'meme warfare.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x8625046fed55ed64c3bd3f4d98494e64584ee60b.png?size=lg&key=7abdc9")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<META>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<META>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<META>>(v1);
    }

    // decompiled from Move bytecode v6
}

