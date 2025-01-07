module 0x91a617b4e9df392d50e196fb189ec749f47111309ba572c53d504a60807a92b7::BLUEMOVE {
    struct BLUEMOVE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUEMOVE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLUEMOVE>>(0x2::coin::mint<BLUEMOVE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDonorList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEMOVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUEMOVE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUEMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEMOVE>(arg0, 9, b"SWEETIE", b"Sweetie the evil", b"Sweety the evil on SUI 1M $$$$ token comming soon", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEMOVE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEMOVE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEMOVE>>(v3, @0xfb0ce8a725e0141a8a5331829a155a5c66bbb047002de9f0afb4b694f4103d9f);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEMOVE>>(v1, @0xfb0ce8a725e0141a8a5331829a155a5c66bbb047002de9f0afb4b694f4103d9f);
    }

    public entry fun removeFromDonorList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEMOVE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUEMOVE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

