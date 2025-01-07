module 0xb1559a2b637fca9e234509e693e40ef582aa3aa720ed3142f6c8eb6e28d921e8::hippocat {
    struct HIPPOCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HIPPOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HIPPOCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HIPPOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HIPPOCAT>(arg0, 9, b"HippoCat", b"HippoCat", b"HippoCat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<HIPPOCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPOCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HIPPOCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HIPPOCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HIPPOCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

