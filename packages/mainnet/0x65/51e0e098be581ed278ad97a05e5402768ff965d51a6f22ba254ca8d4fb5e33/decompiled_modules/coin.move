module 0x6551e0e098be581ed278ad97a05e5402768ff965d51a6f22ba254ca8d4fb5e33::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::create_wrapped::WrappedAssetSetup<COIN, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__0_2_0>>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::create_wrapped::prepare_registration<COIN, 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::version_control::V__0_2_0>(arg0, 6, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

