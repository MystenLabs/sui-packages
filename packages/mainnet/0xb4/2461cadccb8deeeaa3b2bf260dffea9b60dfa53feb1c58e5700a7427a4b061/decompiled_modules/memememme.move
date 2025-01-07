module 0xb42461cadccb8deeeaa3b2bf260dffea9b60dfa53feb1c58e5700a7427a4b061::memememme {
    struct MEMEMEMME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMEMME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEMEMME>(arg0, 9, b"MEMEMEMME", b"Bhao", b"It's dogs plus cats combination ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/813bef1a-9065-417e-8794-fa9063f99db7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMEMME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEMEMME>>(v1);
    }

    // decompiled from Move bytecode v6
}

