module 0xfb412917a575d08d0e2c1b190c1c999add96ca196dc5fcba27773ae9edd07115::catwifcat {
    struct CATWIFCAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATWIFCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CATWIFCAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CATWIFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CATWIFCAT>(arg0, 9, b"CatWifCat", b"CatWifCat", b"CatWifCat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CATWIFCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATWIFCAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIFCAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CATWIFCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CATWIFCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CATWIFCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

