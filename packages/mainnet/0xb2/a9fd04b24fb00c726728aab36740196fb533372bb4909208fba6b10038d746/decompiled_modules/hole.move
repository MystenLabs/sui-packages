module 0xb2a9fd04b24fb00c726728aab36740196fb533372bb4909208fba6b10038d746::hole {
    struct HOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLE>(arg0, 9, b"HOLE", b"Hole", b"Hole is a MeMeCoiN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/815a75f5-c9ef-4aab-a67e-be623a3a88c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

