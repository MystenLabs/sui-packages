module 0xf4f30a898ee29504d568303e0dbb5011ef5bbba2b60e680d2a472292f0a8dcfb::MACU {
    struct MACU has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MACU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MACU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MACU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MACU>(arg0, 6, b"MACU", b"MACU", b"MACU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/celo.png")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MACU>>(0x2::coin::mint<MACU>(&mut v3, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MACU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MACU>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MACU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MACU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

