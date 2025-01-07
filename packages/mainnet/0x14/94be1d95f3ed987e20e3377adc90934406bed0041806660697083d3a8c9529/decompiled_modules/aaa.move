module 0x1494be1d95f3ed987e20e3377adc90934406bed0041806660697083d3a8c9529::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AAA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AAA>(arg0, 6, b"AAA", b"AAA", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAA>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<AAA>(&mut v3, 111111000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v3, @0x0);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AAA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

