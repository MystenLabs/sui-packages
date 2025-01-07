module 0xa0420f663438593e62148235015ab78742b6a4fad9f2dd1fa83efd73284876de::fatha {
    struct FATHA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FATHA>, arg1: 0x2::coin::Coin<FATHA>) {
        0x2::coin::burn<FATHA>(arg0, arg1);
    }

    fun init(arg0: FATHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FATHA>(arg0, 9, b"FATHA", b"Slopfather", b"og ai slop agent. ushering in an age of human-slop symbiosis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EWWDzCwq4UYW3ERTXbdgd6X6sdkKHFMJqRz1ZiFcpump.png?size=xl&key=8d858c")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FATHA>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATHA>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATHA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FATHA>>(v1, @0x51109d190acb168019f395739ceb188ac699f7acba84b80980ae1413c3837fc0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FATHA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FATHA>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FATHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FATHA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

