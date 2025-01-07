module 0xb0e39a6a8b51f845e10b7b42e3da85d2cbfc442730b1957d4953235ac80ac343::oxlk {
    struct OXLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXLK>(arg0, 9, b"OXLK", b"OXILARYK", b"building design automation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/51123950-c007-4a4d-b566-85d1d46ca9c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OXLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

