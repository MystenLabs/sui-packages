module 0xcde173d4bba69636f5e448d91c733f6baffca79ec874d40ab0be770b03da7db5::mjr {
    struct MJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJR>(arg0, 9, b"MJR", b"MAJOR", b"major", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8cb11b8a-ff0c-4dbd-ae52-d398468607b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

