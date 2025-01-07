module 0x1d8aeaa3df3c03ba7426525aa1ab6879c5635d85f774b25121fa59b5c8d914fa::ciy {
    struct CIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIY>(arg0, 9, b"CIY", b"Cisi cy", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4faaa06-4c46-4c6c-97e3-4931197a9e6b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

