module 0xaf5b52e8b3ad9313e7457f6e09d847d24aeb05551e222cce2fc482ea2b827ad4::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 3, b"S", b"S", b"S IS LITERALLY A MEME COIN.NO UTILITY. NO ROADMAP. NO PROMISES.NO EXPECTATION OF FINANCIAL RETURN.JUST 100% MEMES.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYzNtVYJz45FY4sdL7vyA4Zu9Sexh6Ebp78TvYy2ibGFm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<S>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}

