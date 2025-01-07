module 0x824cc991763c6fd21006e5803e275d7f4e3f837a1ed40d9670b9a3a67dda8696::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"FROG", b"FroggerFi", b"FroggerFi is a meme token featuring a lively and humorous frog mascot, always hopping from one pond to another. This token brings laughter and connection to the crypto community, while encouraging flexibility and creativity within the blockchain space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/14cc758a-08e0-4484-8fe8-9029f5ec7ffa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

