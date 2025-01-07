module 0xed44da553bb6f6d080c63f40e8f5438ac7cc1e8d06caa8211eb4e8c056915392::sov {
    struct SOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOV>(arg0, 9, b"SOV", b"Solver", b"Solving real life problems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43505aa3-39c5-4645-b141-8c372427b02d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOV>>(v1);
    }

    // decompiled from Move bytecode v6
}

