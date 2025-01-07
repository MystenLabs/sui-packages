module 0xf01e12e9d96f647d8a800e53a498ac531213a3c83284e0d498bca59a1d289b96::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 9, b"DOL", b"DolphCoin ", b"DolphCoin is a community-driven meme coin promoting ocean conservation, positivity, and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db877542-02d7-4ac2-852c-b01b09f4879f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

