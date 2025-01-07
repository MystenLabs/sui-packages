module 0x71f9802d23f78a265047b15648f484066fb84d37a0a0dd92f99bb04a96168569::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 9, b"MIKU", b"MikuAi", x"4f6861796f6f6f6f212057617461736869207761204d696b7520446573757e202820e280a2cc8020cf8920e280a2cc812029e29ca7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/fczy4cBWZ5FD5vc7rEaVDDseCtf9m64t3rrax7Lpump.png?size=xl&key=61c8fd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIKU>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

