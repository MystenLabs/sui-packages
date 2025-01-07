module 0xb825e73ba77bca4b7dfca8e6fda1862b3c8077dc73a9403434c168311ef4997e::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAME>(arg0, 9, b"BOT", b"SUIBotics", x"496e20746865207965617220323035302c20537569426f746963732072756c65642074686520626c6f636b636861696e2e205468657365204149206167656e7473207472616465642c20676f7665726e65642c20616e64206f75747769747465642068756d616e73206f6e205375692c206c656176696e6720757320746f20636865657220666f7220746865697220e2809c656666696369656e6379e2809d207768696c652074686579206f7074696d697a65642065766572797468696e67e280946578636570742075732e2054686520667574757265207761736ee28099742068756d616e3b206974207761732070726f746f636f6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQpQ52Eow1eFTaR8y8crT7AU3eosVq4mfVtqwKW5oiLqv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAME>(&mut v2, 1000000000000000000, @0xae42d2ec4d8ad9708972e523c8aad72bdd89ee7df04afc8a221545ac9577763c, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

