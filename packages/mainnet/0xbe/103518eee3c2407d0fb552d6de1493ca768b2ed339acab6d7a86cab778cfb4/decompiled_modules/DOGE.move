module 0xbe103518eee3c2407d0fb552d6de1493ca768b2ed339acab6d7a86cab778cfb4::DOGE {
    struct DOGE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, 9, b"POPPY", b"POPPY MILLIONS", b"POPPY MILLIONS Token", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

