module 0x21f183516cd631092100cdbce4e79d872972d899b38a9289f78ff74e2ccfd04c::corona {
    struct CORONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORONA>(arg0, 9, b"CORONA", b"Wave", b"Sui inspires to go further, develop, catch the waves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3b6313b0-6ce3-4ba2-bbd1-55f4beea980f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

