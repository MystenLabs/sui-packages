module 0x417be63a5b256bb6c3ad0332aa585bbd356064c47102f3f4be12b0a6194e4387::cday {
    struct CDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDAY>(arg0, 9, b"CDAY", b"ChickenDay", b"Token for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4bffbcc-0b95-4475-a1d5-fb04fa892311.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

