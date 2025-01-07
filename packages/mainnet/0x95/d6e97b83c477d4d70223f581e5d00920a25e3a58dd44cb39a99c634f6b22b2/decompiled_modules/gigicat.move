module 0x95d6e97b83c477d4d70223f581e5d00920a25e3a58dd44cb39a99c634f6b22b2::gigicat {
    struct GIGICAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GIGICAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GIGICAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: GIGICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GIGICAT>(arg0, 9, b"GigiCat", b"Sui Gigi Cat", b"Sui Gigi Cat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GIGICAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIGICAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGICAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GIGICAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GIGICAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GIGICAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

