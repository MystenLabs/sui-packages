module 0x381d7226d000841c744ab1a0903eb51da3ed36b775c51b4e1579dd72d3c992d4::bluebrett {
    struct BLUEBRETT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEBRETT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUEBRETT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUEBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEBRETT>(arg0, 9, b"BlueBrett", b"Blue Brett", b"Blue Brett Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEBRETT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEBRETT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBRETT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEBRETT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUEBRETT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUEBRETT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

