module 0xa7edeef009a45e0480a4aacae9d65d44c1863d8837e955089b7af7abba460646::chb_1244 {
    struct CHB_1244 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHB_1244, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHB_1244>(arg0, 9, b"CHB_1244", b"MOON", b"TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/473bcd41-d6d9-46ef-a268-97ab0db6f0d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHB_1244>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHB_1244>>(v1);
    }

    // decompiled from Move bytecode v6
}

