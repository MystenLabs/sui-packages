module 0xd2ee00c33a3f41f683aac7c6dce0b88a0505dbdba06f8731c8b82cb387011e64::specimens {
    struct SPECIMENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPECIMENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPECIMENS>(arg0, 9, b"SPECIMENS", b"JAGANNATH", b"A meme coin that will move the crypto space, looking nice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cc6f9b1-5996-4958-b67e-711a861af2f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPECIMENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPECIMENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

