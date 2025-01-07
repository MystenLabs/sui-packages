module 0xd7d13ca96334b03cde99e7d9e3c2d8e40addd9bf16146ff2494c9bb32f0b780f::alc {
    struct ALC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALC>(arg0, 9, b"ALC", b"Alina Coin", b"Alina Coin is a digital currency designed to create a vibrant and empowering ecosystem for women-led initiatives and projects. Alina, derived from the Latin word for \"light\" and the meaning \"beautiful,\" represents the shining potential within everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd69bbd9-dabe-4715-a96a-6375918d425b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALC>>(v1);
    }

    // decompiled from Move bytecode v6
}

