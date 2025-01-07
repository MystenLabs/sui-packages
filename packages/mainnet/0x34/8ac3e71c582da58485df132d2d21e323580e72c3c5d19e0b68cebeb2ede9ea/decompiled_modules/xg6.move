module 0x348ac3e71c582da58485df132d2d21e323580e72c3c5d19e0b68cebeb2ede9ea::xg6 {
    struct XG6 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XG6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XG6>>(0x2::coin::mint<XG6>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XG6>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XG6>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: XG6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XG6>(arg0, 6, b"xg6", b"xiaogao666", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"1"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XG6>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XG6>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<XG6>(&mut v3, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XG6>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XG6>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<XG6>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

