module 0x2a52fc4f3e3670910a63f00669de266cfa89c773a8136168ea335eb9c89c05d9::dellcantic {
    struct DELLCANTIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELLCANTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELLCANTIC>(arg0, 9, b"DELLCANTIC", b"QuocDz", b"Upbo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/647b589a-11b3-4684-9080-7eb19d9b3666.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELLCANTIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELLCANTIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

