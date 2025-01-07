module 0x5797764592860ec2432c53b03652f56bac56b6ac24886384412e5fea8fb80ad1::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 9, b"JUP", b"JUP", b"JUP on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://solana-cdn.com/cdn-cgi/image/width=100/https://assets.coingecko.com/coins/images/34188/large/jup.png?1704266489")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JUP>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

