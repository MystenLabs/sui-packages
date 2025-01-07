module 0xb0ec463ed1c162bbc37aa392ea66feebe6e6e86a3865f4fbe8692349f719cbc::sft {
    struct SFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFT>(arg0, 9, b"SFT", b"STARFINANC", b"STAR FINANCE TOKEN is a community driven meme token built on the SUI BLOCK CHAIN. This meme token is aiming to become the biggest meme token on the SUI BLOCK CHAIN. This has a total supply of 10billion tokens and all for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/92e2fffd-7d4d-4c13-beb0-7cedb90afe82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

