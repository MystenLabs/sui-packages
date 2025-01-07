module 0x7d57dc274be13e71fb2a2b687543ee418d88986c936b550b6c6f4895e25af994::lp {
    struct LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LP>(arg0, 9, b"LP", b"LUKE PIX", b"The LUKE PIX (LP) coin is a meme token inspired by the joke that LUKE is the \"CEO\" of the game, symbolizing humor and creativity in the GameFi world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86a87ca4-2a4e-4e4e-a94a-5ebf06bfb220.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LP>>(v1);
    }

    // decompiled from Move bytecode v6
}

