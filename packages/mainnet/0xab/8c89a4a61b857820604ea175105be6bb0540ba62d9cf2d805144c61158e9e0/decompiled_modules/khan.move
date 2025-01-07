module 0xab8c89a4a61b857820604ea175105be6bb0540ba62d9cf2d805144c61158e9e0::khan {
    struct KHAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KHAN>, arg1: 0x2::coin::Coin<KHAN>) {
        0x2::coin::burn<KHAN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KHAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KHAN>>(0x2::coin::mint<KHAN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHAN>(arg0, 9, b"KHAN", b"SHEH", b"Hello", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

