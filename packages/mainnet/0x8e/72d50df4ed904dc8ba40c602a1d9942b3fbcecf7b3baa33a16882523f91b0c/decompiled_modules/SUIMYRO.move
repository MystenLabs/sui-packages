module 0x8e72d50df4ed904dc8ba40c602a1d9942b3fbcecf7b3baa33a16882523f91b0c::SUIMYRO {
    struct SUIMYRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMYRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMYRO>(arg0, 6, b"Sui MYRO", b"SUIMYRO", b"https://pbs.twimg.com/profile_images/1746070003307425793/sZpTwIY5_400x400.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMYRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMYRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIMYRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIMYRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

