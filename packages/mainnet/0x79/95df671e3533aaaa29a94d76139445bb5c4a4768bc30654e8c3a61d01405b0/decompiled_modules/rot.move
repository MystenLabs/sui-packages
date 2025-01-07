module 0x7995df671e3533aaaa29a94d76139445bb5c4a4768bc30654e8c3a61d01405b0::rot {
    struct ROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROT>(arg0, 9, b"ROT", b"Rotschild", b"Rotschild ($ROT) is the ultimate meme coin in the crypto world, blending humor with a nod to the legendary Rotschild family name.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ae9f58e-3e6c-4813-9681-d68bb98667e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

