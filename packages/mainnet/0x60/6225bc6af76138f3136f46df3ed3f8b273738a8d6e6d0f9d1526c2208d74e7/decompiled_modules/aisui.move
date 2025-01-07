module 0x606225bc6af76138f3136f46df3ed3f8b273738a8d6e6d0f9d1526c2208d74e7::aisui {
    struct AISUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AISUI>, arg1: 0x2::coin::Coin<AISUI>) {
        0x2::coin::burn<AISUI>(arg0, arg1);
    }

    fun init(arg0: AISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISUI>(arg0, 2, b"SUIGG", b"SUIG", b"https://www.google.com.hk/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AISUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AISUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

