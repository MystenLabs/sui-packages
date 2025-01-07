module 0x2385a74d9381c908685c0d20f5594b8f2a411d04e58ab3b07b9dfd3d50b6a291::fsdg {
    struct FSDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSDG>(arg0, 9, b"FSDG", b"FD", b"DGSH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40424665-b406-4da2-95b1-35df348163fc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

