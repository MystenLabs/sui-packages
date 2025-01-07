module 0x1b66167254224cec4d78f769981bd299392a0d83d78b6e5697433b4cfb5b491d::dloi {
    struct DLOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DLOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DLOI>(arg0, 9, b"DLOI", b"Dung", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2752d797-e222-4356-965e-1cc6da7f2941.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DLOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DLOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

