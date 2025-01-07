module 0xd1f4653696970db9a58223aba5a7767e41dd97d3d82472c6184da7b8891a9737::nip {
    struct NIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIP>(arg0, 9, b"NIP", b"Nipple", b"What beats the feminine sensual appeal of the female nipple? Nothing!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/015821db-1836-42e8-bc51-1940fea7e087.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

