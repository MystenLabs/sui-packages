module 0x683c474e0eb99cbc7b02c08972181012086379612eb5529453a6ea1925369800::bigg {
    struct BIGG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIGG>, arg1: 0x2::coin::Coin<BIGG>) {
        0x2::coin::burn<BIGG>(arg0, arg1);
    }

    fun init(arg0: BIGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BIGG>(arg0, 9, b"BIGG", b"BIGG", b"BIG BOSS SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/avalanche/0x2d0afed89a6d6a100273db377dba7a32c739e314.png?size=xl&key=ee00e0")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BIGG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BIGG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BIGG>>(v1, @0xe0c8df9539ae10dcedada4b81b6b209883c47d4d89cae1d8de9d29e1a2d1b359);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BIGG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BIGG>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIGG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIGG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

