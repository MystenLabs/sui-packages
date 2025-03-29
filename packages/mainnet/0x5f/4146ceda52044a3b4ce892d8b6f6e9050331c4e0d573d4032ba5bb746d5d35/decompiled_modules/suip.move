module 0x5f4146ceda52044a3b4ce892d8b6f6e9050331c4e0d573d4032ba5bb746d5d35::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"SuiPit", b"\"Introducing SuiPit, the pitbull of memes on the Sui network! Fierce, loyal, and ready to conquer the blockchain. Join the pack and fly with us to the moon! #SuiPitPower\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sw_Odug_UX_400x400_798c9cf377.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

