module 0x8c3efc0860e962f36dbd2e2b778fb19c00a065918c3a0b7843a23f9f0bfd7cb9::crwn {
    struct CRWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRWN>(arg0, 9, b"CRWN", b"Crown ", b"These meme token was created from my traditional yoruba name, Adetunji Adefioye (Ade). Let's come together to celebrate a traditional yoruba name from Nigeria. Thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d62f579-3006-4fe5-92e9-301d64fbc633.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

