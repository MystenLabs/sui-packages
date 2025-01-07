module 0x65bb52e8613ac4b794e0d668dfe5747b7104e00159071a8e7fd3cc534e23517::trump47th {
    struct TRUMP47TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP47TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP47TH>(arg0, 9, b"TRUMP47TH", b"Trump47", b"America President 47th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e903be7-eabf-4a8e-b1db-557127444bf9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP47TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP47TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

