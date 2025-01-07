module 0x5a6252c9da63706c84bd8b58243be294899362b0ff67978c2d3eeca39149585b::gxn {
    struct GXN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GXN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GXN>(arg0, 9, b"GXN", b"Genex", b"A meme for payment of goods and services at a swift rate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d615e1c-f57e-4743-a5ea-f53107abdb86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GXN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GXN>>(v1);
    }

    // decompiled from Move bytecode v6
}

