module 0xd8dfa87fb9f9ac2343c88ea2eca448f4d44e6f0161cac8d83b7bb9f37a2b04d7::WOLF {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WolfPack", b"WOLF", b"A howling meme coin for the pack leaders of crypto. Join the WolfPack and rule the market with strength, strategy, and a bit of wild fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/feRI7keuUlRVyJqW3MQyNNu1Obs5oXqgJ6Zge7uuIIhIA1bUB/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, @0x38aebcc929b0f1d8292ee23932ef3b8cbcb247b6175b712cc1e162b6d58411b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

