module 0x64a35cd8a30a48397f2d8a45f28600d62a40bbcaed759059a86486b332fbb496::lnb {
    struct LNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNB>(arg0, 9, b"LNB", b"Lengocbe", b"Tabon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f6e5887-c146-4df2-a163-b2516068feb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

