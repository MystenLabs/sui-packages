module 0xc52d00c83a1f617a82c85a5b96f9072041ebaaec8df78e07e83e2dfd3df5be22::marketcap {
    struct MARKETCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARKETCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKETCAP>(arg0, 9, b"mcap", b"market cap", b"the marketing is the market cap | Twitter: https://x.com/i/communities/1942681520403042387 | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiagxl32utqplz4kbgo7a26oiuiwzzuruo2z42aeq4yzcq6rrdy5dy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARKETCAP>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKETCAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARKETCAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

