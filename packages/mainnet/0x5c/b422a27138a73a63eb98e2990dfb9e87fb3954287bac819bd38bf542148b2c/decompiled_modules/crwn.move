module 0x5cb422a27138a73a63eb98e2990dfb9e87fb3954287bac819bd38bf542148b2c::crwn {
    struct CRWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRWN>(arg0, 9, b"CRWN", b"Crown", b"These meme token was created from my traditional yoruba name, Adetunji Adefioye (Ade). Let's come together to celebrate a traditional yoruba name from Nigeria. Thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/883f9a71-12ba-4156-9f5c-ba8737e434e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

