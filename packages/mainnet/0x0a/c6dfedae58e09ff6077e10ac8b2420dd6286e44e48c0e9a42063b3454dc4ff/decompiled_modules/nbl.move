module 0xac6dfedae58e09ff6077e10ac8b2420dd6286e44e48c0e9a42063b3454dc4ff::nbl {
    struct NBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBL>(arg0, 9, b"NBL", b"Noble", b"For innovation and community friendly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ef2bde5-d993-4795-82e5-eaa929e653e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

