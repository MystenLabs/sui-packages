module 0xfd6ab07e0f88163ed85baecd91b9bf304922a02d64d9a4c96c1d3a1625a12631::avtr {
    struct AVTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVTR>(arg0, 9, b"AVTR", b"Avatar", b"Wind,water,fire,earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e5db794-ce67-4baf-91a3-7136460d6620.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

