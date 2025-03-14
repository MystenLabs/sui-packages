module 0x64ecd8c88c991cf88586d4ff6de041a1511a4d58cf4cf2d7535e9a9ac4c0008e::ehs {
    struct EHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHS>(arg0, 9, b"EHS", b"Ehsan", b"ehsan token on the wawe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f097a9e-2d52-4b8e-a95e-a12ea9d83a4b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

