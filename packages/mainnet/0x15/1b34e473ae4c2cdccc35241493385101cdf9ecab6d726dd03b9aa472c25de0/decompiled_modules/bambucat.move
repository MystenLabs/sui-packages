module 0x151b34e473ae4c2cdccc35241493385101cdf9ecab6d726dd03b9aa472c25de0::bambucat {
    struct BAMBUCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAMBUCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BAMBUCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BAMBUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BAMBUCAT>(arg0, 9, b"BAMBUCAT", b"BAMBU CAT", b"BAMBU CAT MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BAMBUCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAMBUCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBUCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BAMBUCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BAMBUCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BAMBUCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

