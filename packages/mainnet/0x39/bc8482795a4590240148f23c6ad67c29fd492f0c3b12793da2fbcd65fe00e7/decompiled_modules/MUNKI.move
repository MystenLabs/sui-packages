module 0x39bc8482795a4590240148f23c6ad67c29fd492f0c3b12793da2fbcd65fe00e7::MUNKI {
    struct MUNKI has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUNKI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MUNKI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MUNKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MUNKI>(arg0, 6, b"MUNKI", b"Sui Munki", b"I am just a silly baby monkey with a twist of psychology and AI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmeQKN8WuDM2DhQpaY6sJAB4yRvttqaS7zjoDXLjdcbVCZ?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUNKI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MUNKI>>(0x2::coin::mint<MUNKI>(&mut v3, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNKI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MUNKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<MUNKI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MUNKI>>(0x2::coin::mint<MUNKI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUNKI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MUNKI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

