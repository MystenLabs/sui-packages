module 0xa4e0dc6bc3744d63990d1a21de5e49af510da37509b9a1e0e518ab2ca9406beb::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"SAVIOR", b"Savior one", b"an Art Nouveau-inspired depiction of Elphaba and The Wonderful Wizard of Oz in a glowing throne room", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibglbk3hancowp2oxrroytsoxukq2spbo5bi6gu2wpovtpebawdtq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAVIOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

