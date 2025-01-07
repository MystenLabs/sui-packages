module 0xa7003fe3d633333c5c9816cb920f7d16c2a8057ecfc1a9d7cea6e095b935d3da::bbbbbb {
    struct BBBBBB has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BBBBBB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BBBBBB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BBBBBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BBBBBB>(arg0, 6, b"BBBBBB", b"AAAAA", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBBBBB>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BBBBBB>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<BBBBBB>(&mut v3, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBBBBB>>(v3, @0x0);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BBBBBB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BBBBBB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

