module 0x5f1743b0ad26e0c7a6e9cb34a9c2df2dbae9be5c6c51a48638fc74237063cde5::ahug001 {
    struct AHUG001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHUG001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHUG001>(arg0, 9, b"AHUG001", b"AHUG", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3442f6db-0950-471e-b00b-ccd04ea92331.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHUG001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHUG001>>(v1);
    }

    // decompiled from Move bytecode v6
}

