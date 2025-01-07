module 0x2a78de28a5b0bc1a8bbf976096c9130a02c3c7a3f5bd09d2868be171018175bb::angcat {
    struct ANGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGCAT>(arg0, 9, b"ANGCAT", b"ANGRYCAT ", b"ANGRYCAT wewe inspired by original wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a80474b5-7658-4d19-8def-7715fc25248f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

