module 0xdb5c6539d04686443c834a396dda6f9f36d0ed20fe69757e8507919931c91c4c::hihi {
    struct HIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIHI>(arg0, 9, b"HIHI", b"Hi", b"HiHiHi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07220e5c-f418-4b4b-9b31-ede087aafd0c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

