module 0xc13522df244641b00170d7a117aa55559a6f7c3df836420b22969f92604b2cda::cdc {
    struct CDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDC>(arg0, 9, b"CDC", b"Habeeb", b"My first token in this block chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8a0443e-b2d5-465d-8683-2bcfb587fe70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

