module 0x46de1d04ab22e3b9f4589264f8f1dbd9e7b1972805276f8656d2865c848a979b::bbraca {
    struct BBRACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBRACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBRACA>(arg0, 9, b"BBRACA", b"Babyracav3", x"4261627920726163612076332069732061207369676e69666963616e74207374657020666f727761726420696e20746865206a6f75726e657920746f20776562203320636f6d62696e696e672041692c2055534d20616e64204d65746176657273652077696c6c2062652061207374657070696e672073746f6e6520746f20656c657661746520526163612056332e20436f6d652077697468206d6520f09f9a80f09f9a80f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aade7432-c4fc-4393-ac92-c89146ebed62-BABYRACA.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBRACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBRACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

