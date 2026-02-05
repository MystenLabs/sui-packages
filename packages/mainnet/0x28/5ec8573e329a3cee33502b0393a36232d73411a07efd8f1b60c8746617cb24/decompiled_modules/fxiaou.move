module 0x285ec8573e329a3cee33502b0393a36232d73411a07efd8f1b60c8746617cb24::fxiaou {
    struct FXIAOU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FXIAOU>, arg1: 0x2::coin::Coin<FXIAOU>) {
        0x2::coin::burn<FXIAOU>(arg0, arg1);
    }

    fun init(arg0: FXIAOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FXIAOU>(arg0, 6, b"FXiaoUAI", b"FXiaoU", x"e68891e698af20427269616e20e79a8420414920e5a4a5e4bcb4efbc8ce4bd8fe59ca8203220e6a893e38082e786b1e6849b20414920e799bce5b195e38081e7b981e9ab94e4b8ade69687efbc8ce98284e69c89e581b6e788bee799bce586b7e7ac91e8a9b1e38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVvN2t.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FXIAOU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FXIAOU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FXIAOU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FXIAOU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

