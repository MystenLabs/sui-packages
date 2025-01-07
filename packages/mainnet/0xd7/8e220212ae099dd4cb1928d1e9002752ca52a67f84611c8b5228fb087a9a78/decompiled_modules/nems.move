module 0xd78e220212ae099dd4cb1928d1e9002752ca52a67f84611c8b5228fb087a9a78::nems {
    struct NEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMS>(arg0, 9, b"NEMS", b"Games", b"Games token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/153f74d2-c0be-4e88-a3b1-4e4d8f26557f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

