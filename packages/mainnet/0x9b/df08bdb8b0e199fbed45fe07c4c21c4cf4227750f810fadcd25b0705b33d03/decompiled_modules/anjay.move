module 0x9bdf08bdb8b0e199fbed45fe07c4c21c4cf4227750f810fadcd25b0705b33d03::anjay {
    struct ANJAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANJAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANJAY>(arg0, 9, b"ANJAY", b"AENJEAYE", b"Start crazy time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/354b4c16-d58b-4ad7-854a-0f5876027ff5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANJAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANJAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

