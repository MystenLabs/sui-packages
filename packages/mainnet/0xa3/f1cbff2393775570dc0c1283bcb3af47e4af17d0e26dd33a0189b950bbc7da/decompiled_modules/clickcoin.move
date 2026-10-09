module 0xa3f1cbff2393775570dc0c1283bcb3af47e4af17d0e26dd33a0189b950bbc7da::clickcoin {
    struct CLICKCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLICKCOIN>, arg1: 0x2::coin::Coin<CLICKCOIN>) {
        0x2::coin::burn<CLICKCOIN>(arg0, arg1);
    }

    fun init(arg0: CLICKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLICKCOIN>(arg0, 6, b"CC", b"CLICK COIN", b"GET REWARDS POINTS/TOKENS/COINS IN CLICK COIN (TM) TO CLICK AND GIVE YOUR HONEST FEEDBACK ON THE NEWEST NFT'S ON THE INTERNET. NOT LIABLE FOR ANY LOSS OF FUNDS. PLEASE VIEW THE TERMS OF SERVICE ONLINE. BUILT BY AMERICANS FOR AMERICANS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiffk5u7pnm64krutu2eshbgesbmy535m7j76px27kktua3ne2prma")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLICKCOIN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLICKCOIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLICKCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLICKCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLICKCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

