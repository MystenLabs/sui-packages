module 0x2cc414940d25a958d6ea6289bf802a180f4e9239fe45eaef38e4487bc4fd6f91::spacemuffin {
    struct SPACEMUFFIN has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACEMUFFIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPACEMUFFIN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPACEMUFFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPACEMUFFIN>(arg0, 9, b"sMuffin", b"Space Muffin", b"Space Muffin Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.scdn.co/image/ab67616d00001e0279857d8de56e0993b337fdb8")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPACEMUFFIN>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACEMUFFIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEMUFFIN>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPACEMUFFIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACEMUFFIN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPACEMUFFIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

