module 0x76f90f08142e79cb3d37e225a386a8c799a170e04c7b2d167e7c4f6947a0b818::moonlight {
    struct MOONLIGHT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOONLIGHT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MOONLIGHT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MOONLIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MOONLIGHT>(arg0, 9, b"Moonlight", b"Moonlight Protocol", b"Moonlight Protocol Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MOONLIGHT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONLIGHT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLIGHT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MOONLIGHT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOONLIGHT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MOONLIGHT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

