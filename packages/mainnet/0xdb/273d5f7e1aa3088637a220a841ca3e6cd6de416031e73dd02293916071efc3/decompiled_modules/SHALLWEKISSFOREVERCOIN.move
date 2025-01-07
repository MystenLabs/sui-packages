module 0xdb273d5f7e1aa3088637a220a841ca3e6cd6de416031e73dd02293916071efc3::SHALLWEKISSFOREVERCOIN {
    struct SHALLWEKISSFOREVERCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHALLWEKISSFOREVERCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHALLWEKISSFOREVERCOIN>(arg0, 6, b"SWKFC", b"ShallWeKissForeve Coin", b"SUI Move task 2 coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHALLWEKISSFOREVERCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHALLWEKISSFOREVERCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHALLWEKISSFOREVERCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHALLWEKISSFOREVERCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

