module 0x9352a64abecd2e6fa2ea1383a13fee0edeceb32ceb20627dbaaa1764eb04b88f::MACU {
    struct MACU has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MACU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MACU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MACU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MACU>(arg0, 6, b"MACU", b"MACU", b"MACU Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/celo.png")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MACU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MACU>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MACU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MACU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

