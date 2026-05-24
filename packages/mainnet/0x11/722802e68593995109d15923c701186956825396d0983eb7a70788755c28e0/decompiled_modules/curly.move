module 0x11722802e68593995109d15923c701186956825396d0983eb7a70788755c28e0::curly {
    struct CURLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CURLY>(arg0, 9, 0x1::string::utf8(b"CRLY"), 0x1::string::utf8(b"Curly"), 0x1::string::utf8(b"Curly the Pangolin. Building on Sui Network!"), 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeib6ej6sfclbt3wtemfnrfgq5mcvlcuj2gpjmnlvzjhfmp7mcfkugm"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURLY>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<CURLY>>(0x2::coin::mint<CURLY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CURLY>>(0x2::coin_registry::finalize<CURLY>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

