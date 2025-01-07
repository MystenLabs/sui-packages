module 0x60553dc80b59300b8eb9f0abeaf8da789eb712e3f9e2e7fe2c86e0115c61985e::trumpwifblunt {
    struct TRUMPWIFBLUNT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPWIFBLUNT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMPWIFBLUNT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPWIFBLUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMPWIFBLUNT>(arg0, 9, b"TrumpWifBlunt", b"TrumpWifBlunt", b"TrumpWifBlunt Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMPWIFBLUNT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWIFBLUNT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIFBLUNT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMPWIFBLUNT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPWIFBLUNT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMPWIFBLUNT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

