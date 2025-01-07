module 0x5a733e8bebf88a027eb16ccef775fa0d02d0f7e9ce23be48b76c16dcc7b93c5c::catea {
    struct CATEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATEA>(arg0, 9, b"CATEA", b"Cateat", b"Cateat is meme funny cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b729d327-21dd-4ce5-a32e-87b45b187c0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

