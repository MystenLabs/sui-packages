module 0x464f9a590312b6aecff8a2607f0a6c299e3f3698cba81c9840752e1f4437cf1f::p_t {
    struct P_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: P_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P_T>(arg0, 9, b"P_T", b"PAT", b"PT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa160cbd-7251-4635-a07e-68b886ee5801.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P_T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P_T>>(v1);
    }

    // decompiled from Move bytecode v6
}

