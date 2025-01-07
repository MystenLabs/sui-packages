module 0xce84c9c88ef730c35a9fa4a3e1617b109703b026466381041d0ecfee8b1a632e::etalha {
    struct ETALHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETALHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETALHA>(arg0, 9, b"ETALHA", b"Talha ", b"My Name Is Talha Aslam And I have a student.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a56c924-212c-4f38-8d71-3daa592678e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETALHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETALHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

