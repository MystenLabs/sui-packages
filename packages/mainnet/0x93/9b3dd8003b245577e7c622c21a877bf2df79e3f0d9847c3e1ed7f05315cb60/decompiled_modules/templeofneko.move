module 0x939b3dd8003b245577e7c622c21a877bf2df79e3f0d9847c3e1ed7f05315cb60::templeofneko {
    struct TEMPLEOFNEKO has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TEMPLEOFNEKO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TEMPLEOFNEKO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TEMPLEOFNEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TEMPLEOFNEKO>(arg0, 9, b"NEKO", b"Temple Of Neko", x"45766572792046756c6c204d6f6f6e2c20612072697475616c20697320706572666f726d65642e20426c6f6f6420616e64206d696c6b206265636f6d65206f66666572696e6773f09fa9b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TEMPLEOFNEKO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLEOFNEKO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLEOFNEKO>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TEMPLEOFNEKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TEMPLEOFNEKO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TEMPLEOFNEKO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

