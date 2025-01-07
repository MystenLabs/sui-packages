module 0xcc51a6ff79e01c9edb263a52fce8e2bd4203ff33a5f6e759ff0b62c82c981908::nodepay {
    struct NODEPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NODEPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NODEPAY>(arg0, 9, b"NODEPAY", b"NOD", x"4e4f44455041592120596f75e28099726520646f696e6720677265617421204b65657020636f6e6e656374656420746f2074686973206e6574776f726b20746f206561726e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/838c1277-c95b-4469-8e29-7152494af341.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NODEPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NODEPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

