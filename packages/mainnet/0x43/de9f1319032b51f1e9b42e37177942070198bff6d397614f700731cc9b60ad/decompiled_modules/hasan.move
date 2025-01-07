module 0x43de9f1319032b51f1e9b42e37177942070198bff6d397614f700731cc9b60ad::hasan {
    struct HASAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASAN>(arg0, 9, b"HASAN", b"Khosrof", b"The animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/324285b1-1a10-4528-9c67-d53a93dd95c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HASAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

