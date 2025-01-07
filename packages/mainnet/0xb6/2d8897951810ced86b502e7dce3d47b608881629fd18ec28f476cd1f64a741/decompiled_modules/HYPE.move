module 0xb62d8897951810ced86b502e7dce3d47b608881629fd18ec28f476cd1f64a741::HYPE {
    struct HYPE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HYPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HYPE>>(0x2::coin::mint<HYPE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HYPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HYPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HYPE>(arg0, 9, b"MEOWTH", b"MEOWTH USA great again", b"MEOWTH USA great again $$$", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HYPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HYPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HYPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

