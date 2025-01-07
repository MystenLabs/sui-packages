module 0x417d372354111f1b8852ce9cd1787e870e5c866ddff1514a3eb051e1525a01d2::haji {
    struct HAJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAJI>(arg0, 9, b"HAJI", b"Haadi", b"Bhdjdk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c6dcbe2-6ca7-4dc2-a9f0-f6f32282ab16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

