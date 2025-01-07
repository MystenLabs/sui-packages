module 0x83b574c146dcec0268a8367b8ca9c834de38c3ada7260e8b2085e63fa7265f6b::nhu {
    struct NHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NHU>(arg0, 9, b"NHU", b"NHU CUTE", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20a2fd4d-5d0c-4690-9f90-182f2cfa05db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

