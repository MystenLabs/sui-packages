module 0x9c52ee644cb4e4fc1fdc3925f974dcf9a36250fe9626674cee87f1e96735c172::BAZZ {
    struct BAZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BAZZ>(arg0, 6, b"BAZZ", b"Sui Bazz", b"Touch Grass and Eat Ass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPbYMKvjiQVBHoK47odFgdLNjsToQ1Wv5auyB5fsnp3vk?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAZZ>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BAZZ>>(0x2::coin::mint<BAZZ>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAZZ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BAZZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun migrate_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAZZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BAZZ>(arg0, arg1, arg2, arg3);
    }

    public entry fun remove_bubo_addr(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAZZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BAZZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

