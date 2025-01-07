module 0x6637d576a19cefb442787e211dbbc1b6131bc700f39622de762cef82c5dc6d92::jeff {
    struct JEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFF>(arg0, 9, b"JEFF", b"Jeff", b"JEFF Scotte", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/489d1608-6e98-413e-9d09-a7d74b718ab1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

