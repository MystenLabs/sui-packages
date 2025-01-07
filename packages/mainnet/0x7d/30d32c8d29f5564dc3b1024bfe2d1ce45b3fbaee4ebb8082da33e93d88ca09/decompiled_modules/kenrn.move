module 0x7d30d32c8d29f5564dc3b1024bfe2d1ce45b3fbaee4ebb8082da33e93d88ca09::kenrn {
    struct KENRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENRN>(arg0, 9, b"KENRN", b"ksndb", b"dhbe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7dd562c6-2ce5-426b-ab63-70af1cc58126.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KENRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

