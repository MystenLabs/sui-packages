module 0xd2726f014c9fb80ea0b041579112c2f5f23ca3ba5709096bc3b4b09f988402c6::xDino {
    struct XDINO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XDINO>, arg1: 0x2::coin::Coin<XDINO>) {
        0x2::coin::burn<XDINO>(arg0, arg1);
    }

    fun init(arg0: XDINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XDINO>(arg0, 9, b"xDINO", b"XDINO", b"https://pbs.twimg.com/profile_images/1746070003307425793/sZpTwIY5_400x400.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XDINO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDINO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XDINO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XDINO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

