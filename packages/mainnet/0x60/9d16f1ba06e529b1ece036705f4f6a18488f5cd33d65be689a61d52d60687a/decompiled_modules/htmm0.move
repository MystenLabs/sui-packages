module 0x609d16f1ba06e529b1ece036705f4f6a18488f5cd33d65be689a61d52d60687a::htmm0 {
    struct HTMM0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTMM0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTMM0>(arg0, 9, b"HTMM0", b"HTMM", b"Kinle Kin Nahle Mara Khaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18818da3-47b2-4715-9535-adb34bda3d29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTMM0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTMM0>>(v1);
    }

    // decompiled from Move bytecode v6
}

