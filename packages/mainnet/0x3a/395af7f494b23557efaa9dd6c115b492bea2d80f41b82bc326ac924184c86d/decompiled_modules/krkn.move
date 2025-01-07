module 0x3a395af7f494b23557efaa9dd6c115b492bea2d80f41b82bc326ac924184c86d::krkn {
    struct KRKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRKN>(arg0, 9, b"KRKN", b"Kraken", x"6b72616b656e2c20746865204b72616b656e20746f6b656e2c2073796d626f6c697a65732074686520706f776572206f662074686520646565702e2057697468206120676f6c64656e20636f696e206574636865642077697468206f6365616e20776176657320616e6420746865206d6967687479204b72616b656e2c20697420726570726573656e7473206d7973746572792c20737472656e6774682c20616e642074686520756e73746f707061626c6520666f726365206f66206e6174757265e2809461206c6567656e6461727920747265617375726520666f722074686520626f6c642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6629945e-ee3a-4fc1-ba0d-044f8456097e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

