module 0x1bb129b086ffada073d5a419f67702aa3310f4e42f5ffbb1eda36a946d29f984::loopy_sui {
    struct LOOPY_SUI has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LOOPY_SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LOOPY_SUI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LOOPY_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LOOPY_SUI>(arg0, 9, b"LOOPY", b"LOOPY", b"The most adorable cult to ever invade SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-tremendous-canidae-396.mypinata.cloud/ipfs/QmSNRiCLDCZ2RJFvn9mJ7gmWpm45pgNAZeJJ3wYEkaje5F")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOPY_SUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LOOPY_SUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<LOOPY_SUI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOPY_SUI>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LOOPY_SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LOOPY_SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

