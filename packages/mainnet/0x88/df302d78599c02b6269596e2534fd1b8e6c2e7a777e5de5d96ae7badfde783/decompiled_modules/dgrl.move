module 0x88df302d78599c02b6269596e2534fd1b8e6c2e7a777e5de5d96ae7badfde783::dgrl {
    struct DGRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGRL>(arg0, 9, b"DGRL", b"DADY'SGIRL", b"DADY'SGIRL is a fun, community-driven meme coin celebrating the bond between fathers and daughters. With a heartwarming spirit and playful energy, DADY'SGIRL is a symbol of trust, love, and good times in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d47ead0a-e14b-42b4-acb3-25e4698effba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

