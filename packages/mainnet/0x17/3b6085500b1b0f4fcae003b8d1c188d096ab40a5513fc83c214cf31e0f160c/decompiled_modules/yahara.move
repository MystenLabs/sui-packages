module 0x173b6085500b1b0f4fcae003b8d1c188d096ab40a5513fc83c214cf31e0f160c::yahara {
    struct YAHARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAHARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAHARA>(arg0, 9, b"YAHARA", b"Honda", b"Bike", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a67b2984-3a27-4ae2-9f24-94eec1dd4a08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAHARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAHARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

