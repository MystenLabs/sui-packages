module 0x4fb4bcbc6cea24fe3f0c3b08ce241b8e6bed645dfecfa3920dedad44cf01718a::cub {
    struct CUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUB>(arg0, 9, b"CUB", b"cute", b"cute shiba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50534ca9-93ba-492e-97ff-08184f71a9c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

