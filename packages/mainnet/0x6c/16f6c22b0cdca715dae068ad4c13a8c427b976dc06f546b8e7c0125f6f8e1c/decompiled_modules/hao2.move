module 0x6c16f6c22b0cdca715dae068ad4c13a8c427b976dc06f546b8e7c0125f6f8e1c::hao2 {
    struct HAO2 has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAO2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HAO2>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HAO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAO2>(arg0, 9, b"HAO2", b"HAO002", b"002", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"http://p4.itc.cn/images01/20210105/909046e342f941f991b0eca33a9042a5.jpeg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HAO2>(&mut v3, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAO2>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAO2>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAO2>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAO2>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HAO2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

