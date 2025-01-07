module 0x809ad4b29c0a695fd757b624331f52439b3b14daa80ecf86ad8f563656e33801::regcoin {
    struct REGCOIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<REGCOIN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGCOIN>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun deny_list_disable_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<REGCOIN>(arg0, arg1, arg2);
    }

    public entry fun deny_list_enable_pause(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<REGCOIN>(arg0, arg1, arg2);
    }

    fun init(arg0: REGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGCOIN>(arg0, 6, b"REGCOIN", b"ELOOO coin", b"elooo", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<REGCOIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<REGCOIN> {
        0x2::coin::mint<REGCOIN>(arg0, arg1, arg2)
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<REGCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REGCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

