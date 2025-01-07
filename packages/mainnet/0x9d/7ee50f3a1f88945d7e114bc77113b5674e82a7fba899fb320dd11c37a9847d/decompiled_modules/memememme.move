module 0x9d7ee50f3a1f88945d7e114bc77113b5674e82a7fba899fb320dd11c37a9847d::memememme {
    struct MEMEMEMME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMEMME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEMEMME>(arg0, 9, b"MEMEMEMME", b"Bhao", b"It's dogs plus cats combination ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9c853a2-5d09-421b-b786-7c145974b2fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMEMME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEMEMME>>(v1);
    }

    // decompiled from Move bytecode v6
}

