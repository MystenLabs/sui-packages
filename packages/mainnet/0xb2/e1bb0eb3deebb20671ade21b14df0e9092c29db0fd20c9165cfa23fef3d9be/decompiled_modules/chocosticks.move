module 0xb2e1bb0eb3deebb20671ade21b14df0e9092c29db0fd20c9165cfa23fef3d9be::chocosticks {
    struct CHOCOSTICKS has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHOCOSTICKS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHOCOSTICKS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CHOCOSTICKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHOCOSTICKS>(arg0, 9, b"ChocoSticks", b"ChocoSticks", b"ChocoSticks Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHOCOSTICKS>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOCOSTICKS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCOSTICKS>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHOCOSTICKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHOCOSTICKS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHOCOSTICKS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

