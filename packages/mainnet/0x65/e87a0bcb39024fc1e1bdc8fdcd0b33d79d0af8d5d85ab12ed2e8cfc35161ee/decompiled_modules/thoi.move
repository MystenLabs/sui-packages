module 0x65e87a0bcb39024fc1e1bdc8fdcd0b33d79d0af8d5d85ab12ed2e8cfc35161ee::thoi {
    struct THOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THOI>(arg0, 9, b"THOI", b"Nhen", b"My love dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56cc91ce-9f43-4ac5-a13d-203f73296e98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

