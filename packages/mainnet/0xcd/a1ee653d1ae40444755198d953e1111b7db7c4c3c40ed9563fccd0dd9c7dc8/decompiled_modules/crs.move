module 0xcda1ee653d1ae40444755198d953e1111b7db7c4c3c40ed9563fccd0dd9c7dc8::crs {
    struct CRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRS>(arg0, 9, b"CRS", b"CRUSH", b"Crush token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c5eccd1-2005-46ff-ad50-b96430b36ff0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

