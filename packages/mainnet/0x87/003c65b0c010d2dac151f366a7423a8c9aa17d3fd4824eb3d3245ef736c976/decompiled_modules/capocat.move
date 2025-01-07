module 0x87003c65b0c010d2dac151f366a7423a8c9aa17d3fd4824eb3d3245ef736c976::capocat {
    struct CAPOCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CAPOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CAPOCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CAPOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CAPOCAT>(arg0, 9, b"CAPOCAT", b"SUI CAPO CAT", b"SUI CAPO CAT MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CAPOCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPOCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPOCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CAPOCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CAPOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CAPOCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

