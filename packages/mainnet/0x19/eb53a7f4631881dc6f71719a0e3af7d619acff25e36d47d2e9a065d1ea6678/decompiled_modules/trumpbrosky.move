module 0x19eb53a7f4631881dc6f71719a0e3af7d619acff25e36d47d2e9a065d1ea6678::trumpbrosky {
    struct TRUMPBROSKY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPBROSKY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMPBROSKY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPBROSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMPBROSKY>(arg0, 9, b"TrumpBrosky", b"TrumpBrosky", b"TrumpBrosky Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMPBROSKY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPBROSKY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPBROSKY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMPBROSKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPBROSKY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMPBROSKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

