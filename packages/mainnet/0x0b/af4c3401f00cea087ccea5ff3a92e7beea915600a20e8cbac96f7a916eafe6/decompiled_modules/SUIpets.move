module 0xbaf4c3401f00cea087ccea5ff3a92e7beea915600a20e8cbac96f7a916eafe6::SUIpets {
    struct SUIPETS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPETS>, arg1: 0x2::coin::Coin<SUIPETS>) {
        0x2::coin::burn<SUIPETS>(arg0, arg1);
    }

    fun init(arg0: SUIPETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPETS>(arg0, 9, b"SUIPETS", b"SUIPETS", b"https://pbs.twimg.com/profile_images/1746070003307425793/sZpTwIY5_400x400.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPETS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPETS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPETS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

