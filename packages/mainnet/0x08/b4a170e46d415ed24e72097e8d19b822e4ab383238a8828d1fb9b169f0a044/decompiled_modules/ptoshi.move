module 0x8b4a170e46d415ed24e72097e8d19b822e4ab383238a8828d1fb9b169f0a044::ptoshi {
    struct PTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOSHI>(arg0, 9, b"PTOSHI", b"IamSatoshi", b"Forbes just confirmed that HBO's documentary is saying Peter Todd is Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b40684f1-2e34-4bb5-81c0-32df195f2923.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

