module 0x1ee0d709b59545ccb1e53fa342d456dea70b77d1934b2a71f111c9081339e125::squishy {
    struct SQUISHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUISHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUISHY>(arg0, 6, b"Squishy", b"$Squishy", b"SQUISHY is like a child's favorite toysoft and squeezable, bringing joy with every touch. Just like a squishy toy that returns to its original shape after being squeezed, the SQUISHY token comes with high flexibility, able to withstand the fluctuations of the crypto market while still holding great potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_5c22b6ed43.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUISHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUISHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

