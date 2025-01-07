module 0x669dfab5a8c52eff5f9b0d0caa64af1d2d777ca4168ced4e1627d35114352cf6::scg {
    struct SCG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCG>(arg0, 6, b"SCG", b"SuiChill", b"The Laid-Back Meme Coin of the Sui Network. is the ultimate chill-out meme coin on the Sui Network, inspired by the internet's favorite \"Chill Guy\" meme., you're not just investing in a token; you're buying into a lifestyle of ease", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732347374248.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

