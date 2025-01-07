module 0xdb273d5f7e1aa3088637a220a841ca3e6cd6de416031e73dd02293916071efc3::SHALLWEKISSFOREVERFAUCETCOIN {
    struct SHALLWEKISSFOREVERFAUCETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHALLWEKISSFOREVERFAUCETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHALLWEKISSFOREVERFAUCETCOIN>>(0x2::coin::mint<SHALLWEKISSFOREVERFAUCETCOIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHALLWEKISSFOREVERFAUCETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHALLWEKISSFOREVERFAUCETCOIN>(arg0, 1, b"SWKFFC", b"ShallWeKissForeve Faucet Coin", b"SUI Move task 2 faucet coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHALLWEKISSFOREVERFAUCETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SHALLWEKISSFOREVERFAUCETCOIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

