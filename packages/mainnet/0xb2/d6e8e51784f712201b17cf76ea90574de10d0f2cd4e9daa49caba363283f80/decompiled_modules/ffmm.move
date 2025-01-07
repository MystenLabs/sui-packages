module 0xb2d6e8e51784f712201b17cf76ea90574de10d0f2cd4e9daa49caba363283f80::ffmm {
    struct FFMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFMM>(arg0, 9, b"FFMM", b"FFMEME", b"It means having the ability to make life decisions without being constrained by financial stress.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/302ef231-3e65-4060-bef4-2f8ff3a862f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FFMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

