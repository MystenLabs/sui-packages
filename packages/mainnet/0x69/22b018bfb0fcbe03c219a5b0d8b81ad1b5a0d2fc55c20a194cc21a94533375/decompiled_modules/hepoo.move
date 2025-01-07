module 0x6922b018bfb0fcbe03c219a5b0d8b81ad1b5a0d2fc55c20a194cc21a94533375::hepoo {
    struct HEPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPOO>(arg0, 9, b"HEPOO", b"Baby hepo", b"Bay hepoo and  grow hipo community this hepo mother is death alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f666a206-5923-437c-9156-3a4ba1c25beb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

