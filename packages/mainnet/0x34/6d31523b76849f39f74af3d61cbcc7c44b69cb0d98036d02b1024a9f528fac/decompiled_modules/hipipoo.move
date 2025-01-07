module 0x346d31523b76849f39f74af3d61cbcc7c44b69cb0d98036d02b1024a9f528fac::hipipoo {
    struct HIPIPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPIPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPIPOO>(arg0, 9, b"HIPIPOO", b"HIPIPO", b"Hi Hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/365e4d22-87fd-4d7f-824c-6771e24f809a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPIPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPIPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

