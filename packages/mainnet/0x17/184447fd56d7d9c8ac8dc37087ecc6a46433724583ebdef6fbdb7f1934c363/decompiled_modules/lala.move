module 0x17184447fd56d7d9c8ac8dc37087ecc6a46433724583ebdef6fbdb7f1934c363::lala {
    struct LALA has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LALA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LALA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LALA>(arg0, 9, b"LALA", b"LOOPY SUI", b"The most adorable cult to ever invade SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LALA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LALA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<LALA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LALA>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LALA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LALA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

