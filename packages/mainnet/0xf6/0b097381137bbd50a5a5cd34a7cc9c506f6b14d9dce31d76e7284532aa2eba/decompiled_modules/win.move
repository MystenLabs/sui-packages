module 0xf60b097381137bbd50a5a5cd34a7cc9c506f6b14d9dce31d76e7284532aa2eba::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WIN>(arg0, 9, b"WIN", b"0xe6b9e1033c72084ad01db37c77778ca53b9c4ebb263f28ffbfed39f4d5fd5057::win::WIN", b"Licensed Casino with no KYC & Instant Cash Out.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchpad.turbos.finance/wintoken.254e43002babf5b30d3151a09cb56115.svg")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<WIN>>(0x2::coin::mint<WIN>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIN>>(v3);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

