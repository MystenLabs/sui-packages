module 0x669e5e6c4f40f265db988af6a0ebc24b7f81f80f1bd369cf76aaaf2324508f64::wifmas {
    struct WIFMAS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WIFMAS>, arg1: 0x2::coin::Coin<WIFMAS>) {
        0x2::coin::burn<WIFMAS>(arg0, arg1);
    }

    fun init(arg0: WIFMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WIFMAS>(arg0, 9, b"WIFMAS", b"wifmas", b"Its the most wonderful time of the year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/CoRQpMjhBx6AsrzKJJZyzJoH52GoEKShM3CVumyzpump.png?size=xl&key=41bce7")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WIFMAS>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFMAS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIFMAS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WIFMAS>>(v1, @0xdfa90820b188f0dd2bcbb16dc5b61edda2962c4e85b814cdb897e25c6a8c4f11);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIFMAS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WIFMAS>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIFMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WIFMAS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

