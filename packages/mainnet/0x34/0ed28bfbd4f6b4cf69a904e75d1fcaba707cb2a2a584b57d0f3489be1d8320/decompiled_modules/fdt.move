module 0x340ed28bfbd4f6b4cf69a904e75d1fcaba707cb2a2a584b57d0f3489be1d8320::fdt {
    struct FDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDT>(arg0, 9, b"FDT", b"Food", b"Foodchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/858b1dbb-5611-4d3f-b494-25cd03b6c2a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

