module 0xf562a4d8f5f56c3e344c92220dfda2db5bb955957317618a415d1c365890462a::catwifglasses {
    struct CATWIFGLASSES has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATWIFGLASSES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CATWIFGLASSES>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CATWIFGLASSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATWIFGLASSES>(arg0, 9, b"CatWifGlasses", b"CatWifGlasses", b"CatWifGlasses Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.istockphoto.com/id/1509572109/vector/lazy-white-cat-with-sunglasses-cartoon-vector-illustration.jpg?s=612x612&w=0&k=20&c=2M4jYBT9w0W6d-Rjoo7nRpWAMbNnFx6UxL8-dpESca0=")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CATWIFGLASSES>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWIFGLASSES>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIFGLASSES>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATWIFGLASSES>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATWIFGLASSES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CATWIFGLASSES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

