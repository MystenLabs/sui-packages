module 0x46f871347246e26119d470a481e306bd25c98e66ae64c3e46821e0a6667b3622::fwogy {
    struct FWOGY has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FWOGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FWOGY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FWOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FWOGY>(arg0, 9, b"FWOGY", b"FWOGY", b"FWOGY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FWOGY>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FWOGY>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOGY>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FWOGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FWOGY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FWOGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

