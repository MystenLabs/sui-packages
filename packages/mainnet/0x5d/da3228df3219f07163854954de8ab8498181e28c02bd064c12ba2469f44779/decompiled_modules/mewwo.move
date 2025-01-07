module 0x5dda3228df3219f07163854954de8ab8498181e28c02bd064c12ba2469f44779::mewwo {
    struct MEWWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWWO>(arg0, 9, b"MEWWO", b"TokenMeow", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47be1cd4-0938-4867-a25f-d74f86fb00e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

