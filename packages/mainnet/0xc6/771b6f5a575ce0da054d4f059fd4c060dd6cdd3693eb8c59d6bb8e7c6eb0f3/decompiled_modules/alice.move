module 0xc6771b6f5a575ce0da054d4f059fd4c060dd6cdd3693eb8c59d6bb8e7c6eb0f3::alice {
    struct ALICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALICE>(arg0, 6, b"ALICE", b"Alice Weider ", x"24414c49434520746f6b656e20697320746865206469676974616c207369676e61747572652064726976696e672061206e65772077617665206f66206c65616465727368697020616e642070726f67726573732e204261636b656420627920696e666c75656e7469616c206669677572657320616e64206675656c6564206279206120766973696f6e20746fc2a053617665204765726d616e792c2024414c494345206973206d6f7265207468616e206a757374206120746f6b656e3b206974e28099732061206d6f76656d656e74210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736344690825.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALICE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALICE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

