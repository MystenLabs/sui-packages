module 0xeaa92c01a0c2282417787087d18e13c03478f8c8f5c54707e95f76fae5ab84a3::sequoai {
    struct SEQUOAI has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SEQUOAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SEQUOAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SEQUOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SEQUOAI>(arg0, 6, b"SEQUOAI", b"SEQUOAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlmQ4cYgdssWL_atXr64egwB4-GMJN_5PcGw&s"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEQUOAI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SEQUOAI>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<SEQUOAI>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEQUOAI>>(v3, @0x0);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SEQUOAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SEQUOAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

