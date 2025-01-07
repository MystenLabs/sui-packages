module 0xb5b1dad06e84306212838e5d768f342f87781c0c526740ab1b6b4a8ff4ec8597::heming {
    struct HEMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEMING>(arg0, 9, b"HEMING", b"ErnestH", b"ernesthemingwaay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49189d6e-0521-4063-b00d-339a1b596273.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEMING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEMING>>(v1);
    }

    // decompiled from Move bytecode v6
}

