module 0x3576b5dfdd55bcc94d4e6af73a0842183967e954aaf3e40694379b0bfbe23962::siba {
    struct MyUrl {
        url: vector<u8>,
    }

    struct SIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIBA>, arg1: 0x2::coin::Coin<SIBA>) {
        0x2::coin::burn<SIBA>(arg0, arg1);
    }

    fun init(arg0: SIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIBA>(arg0, 9, b"SIBA", b"SibaSui", b"https://i.imgur.com/7bNJWlo.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIBA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

