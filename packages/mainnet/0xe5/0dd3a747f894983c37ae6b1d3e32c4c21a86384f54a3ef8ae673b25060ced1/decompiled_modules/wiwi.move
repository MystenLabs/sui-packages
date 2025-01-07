module 0xe50dd3a747f894983c37ae6b1d3e32c4c21a86384f54a3ef8ae673b25060ced1::wiwi {
    struct WIWI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIWI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WIWI>>(0x2::coin::mint<WIWI>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun change_v0(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIWI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WIWI>(arg0, arg1, arg2, arg3);
    }

    public fun change_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIWI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WIWI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WIWI>(arg0, 6, b"WIWI", b"CHIWIWIS", b"CHIWIWIS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1727570344528-3f80305d19fffab75f1158a3d10daec3.jpg"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIWI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WIWI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

