module 0x42baa3d16b05fd9d9f8059cc0724951437f8baaede7b568c536cab0ee287d912::MUSK {
    struct MUSK has drop {
        dummy_field: bool,
    }

    public entry fun addToDonorList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MUSK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MUSK>(arg0, 9, b"TRUMP", b"Trump the best president", b"Trump the best president boost", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MUSK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUSK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MUSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDonorList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MUSK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

