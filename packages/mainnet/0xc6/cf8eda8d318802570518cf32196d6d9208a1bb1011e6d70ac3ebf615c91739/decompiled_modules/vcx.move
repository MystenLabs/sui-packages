module 0xc6cf8eda8d318802570518cf32196d6d9208a1bb1011e6d70ac3ebf615c91739::vcx {
    struct VCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCX>(arg0, 9, b"VCX", b"FD", b"XZC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c707e3a1-1a32-471f-8cb4-8a6024e47b14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

