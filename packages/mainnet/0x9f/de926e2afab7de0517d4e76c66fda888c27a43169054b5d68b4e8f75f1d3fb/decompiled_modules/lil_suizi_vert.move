module 0x9fde926e2afab7de0517d4e76c66fda888c27a43169054b5d68b4e8f75f1d3fb::lil_suizi_vert {
    struct LIL_SUIZI_VERT has drop {
        dummy_field: bool,
    }

    public entry fun add_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LIL_SUIZI_VERT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_add<LIL_SUIZI_VERT>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    public entry fun check_permission(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<LIL_SUIZI_VERT>(arg0, arg1)
    }

    fun init(arg0: LIL_SUIZI_VERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LIL_SUIZI_VERT>(arg0, 9, b"SUIZI", b"Lil Suizi Vert", b"Lil Uzi Vert has bridged to the Sui network and become Lil Suizi Vert.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1854982946463035392/EzReeXoM_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIL_SUIZI_VERT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LIL_SUIZI_VERT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<LIL_SUIZI_VERT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LIL_SUIZI_VERT>>(v3);
    }

    public entry fun remove_deny(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LIL_SUIZI_VERT>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::coin::deny_list_v2_remove<LIL_SUIZI_VERT>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

