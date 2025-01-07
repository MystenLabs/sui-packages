module 0xc6ca9b703b858664c9326b3c19ccf3e7243472c48cf5e53368a27b303a783c9::mnt {
    struct MNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNT>(arg0, 9, b"MNT", b"Mintaka", b"Mintaka, also known as Delta Orionis, is a prominent star in the constellation Orion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d638bcb-f9de-4391-b4df-df94bea87e41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

