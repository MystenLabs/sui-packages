module 0xb16a40a64224cc7a95e918236ee3a4388e4cbdb49dfd15e016f96db1cd98db17::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MYCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MYCOIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MYCOIN>(arg0, 9, b"MYCOIN", b"My Coin", b"something", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmWnmvQQ9cfrXYErZngyC4tQBiJ1TPVFgTDpf3my3cAJRf"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v2);
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MYCOIN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MYCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MYCOIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MYCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

