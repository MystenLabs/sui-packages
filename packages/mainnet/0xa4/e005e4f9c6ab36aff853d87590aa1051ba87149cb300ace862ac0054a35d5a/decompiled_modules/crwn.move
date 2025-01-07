module 0xa4e005e4f9c6ab36aff853d87590aa1051ba87149cb300ace862ac0054a35d5a::crwn {
    struct CRWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRWN>(arg0, 9, b"CRWN", b"Crown ", b"These meme token was created from my traditional yoruba name, Adetunji Adefioye (Ade). Let's come together to celebrate a traditional yoruba name from Nigeria. Thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f597b3e-c4c8-494d-a0c5-51c6ec75ba85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

