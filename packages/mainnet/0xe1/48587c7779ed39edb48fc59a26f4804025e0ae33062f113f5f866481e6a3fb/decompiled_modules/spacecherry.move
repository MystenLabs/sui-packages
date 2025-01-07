module 0xe148587c7779ed39edb48fc59a26f4804025e0ae33062f113f5f866481e6a3fb::spacecherry {
    struct SPACECHERRY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACECHERRY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPACECHERRY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPACECHERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPACECHERRY>(arg0, 9, b"SpaceCherry", b"Sui Space Cherry", b"Sui Space Cherry Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPACECHERRY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACECHERRY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACECHERRY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPACECHERRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACECHERRY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPACECHERRY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

