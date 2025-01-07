module 0x875441034445e4226bf2918c9142008316b86b94aa90bf462ec6872e37785027::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 9, b"SIU", b"Siuuu", b"A meme about Football", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fd9ac10-86b1-4eff-b92a-099149be09d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

