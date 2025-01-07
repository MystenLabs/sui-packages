module 0xc87fcd1d4f1c5a6413c3a331acec6e0810fc3963d316aed8fe779b44fc97a478::MoonPepe {
    struct MOONPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPEPE>(arg0, 6, b"MoonPepe", b"MOONPEPE", b"MoonPepe is a meme token that is a tribute to the original Pepe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmUEWqpegYXapbUaq1z6eVbb5a83AtP7tLiY2iDVVBF3Z7")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

