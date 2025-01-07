module 0xa7e965aa5158ea595dc2921595eb585f2fef5ddd02b3d1fad1545d43c0d9c115::pepemusk {
    struct PEPEMUSK has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEMUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEPEMUSK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEPEMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEPEMUSK>(arg0, 9, b"PepeMusk", b"PepeMusk", b"PepeMusk Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<PEPEMUSK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEMUSK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEMUSK>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEPEMUSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEPEMUSK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEPEMUSK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

