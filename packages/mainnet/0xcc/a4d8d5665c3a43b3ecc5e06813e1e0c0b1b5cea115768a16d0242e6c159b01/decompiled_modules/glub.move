module 0xcca4d8d5665c3a43b3ecc5e06813e1e0c0b1b5cea115768a16d0242e6c159b01::glub {
    struct GLUB has drop {
        dummy_field: bool,
    }

    public entry fun add_to_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GLUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GLUB>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: GLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GLUB>(arg0, 2, b"GLUB", b"GLUB", b"The GLUB Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/FwRo1fWWwAEeuIU.jpg")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLUB>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<GLUB>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUB>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GLUB>>(v1, v4);
    }

    public entry fun remove_from_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GLUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GLUB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

