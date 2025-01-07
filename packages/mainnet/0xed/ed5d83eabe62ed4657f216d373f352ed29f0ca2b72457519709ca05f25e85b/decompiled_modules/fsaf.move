module 0xeded5d83eabe62ed4657f216d373f352ed29f0ca2b72457519709ca05f25e85b::fsaf {
    struct FSAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSAF>(arg0, 9, b"FSAF", b"XSFCAS", b"ZXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf3355d2-c96a-4f4c-b9c9-12139a878451.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FSAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

