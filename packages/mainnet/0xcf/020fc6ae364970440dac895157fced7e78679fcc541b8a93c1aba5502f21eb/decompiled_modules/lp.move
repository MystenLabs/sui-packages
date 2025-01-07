module 0xcf020fc6ae364970440dac895157fced7e78679fcc541b8a93c1aba5502f21eb::lp {
    struct LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP>(arg0, 9, b"LP", b"LUKE PIX", b"The LUKE PIX (LP) coin is a meme token inspired by the joke that LUKE is the \"CEO\" of the game, symbolizing humor and creativity in the GameFi world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/681cdd36-5a25-455f-ba75-8d3540ce03ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP>>(v1);
    }

    // decompiled from Move bytecode v6
}

