module 0x24f4a421b36f2054535e41519562a8dfc3b6d9fe718dc12ebcb83b0955b6699b::visionai {
    struct VISIONAI has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VISIONAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<VISIONAI>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: VISIONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<VISIONAI>(arg0, 9, b"VisionAI", b"VisionAI", b"VisionAI Official Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<VISIONAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VISIONAI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISIONAI>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VISIONAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VISIONAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<VISIONAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

