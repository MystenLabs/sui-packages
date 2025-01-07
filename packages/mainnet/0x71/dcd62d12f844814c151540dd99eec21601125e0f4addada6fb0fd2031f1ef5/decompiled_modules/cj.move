module 0x71dcd62d12f844814c151540dd99eec21601125e0f4addada6fb0fd2031f1ef5::cj {
    struct CJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJ>(arg0, 9, b"CJ", b"Chima JNR", b"Betterment of  the community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67c74535-7c63-4e9f-882a-ba9c6f8e5519.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

