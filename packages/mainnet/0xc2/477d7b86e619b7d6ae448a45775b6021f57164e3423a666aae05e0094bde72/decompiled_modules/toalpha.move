module 0xc2477d7b86e619b7d6ae448a45775b6021f57164e3423a666aae05e0094bde72::toalpha {
    struct TOALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOALPHA>(arg0, 9, b"TOALPHA", b"TORRENT", b"TORRENT is a meme inspired to sharing protocol that uses a peer-to-peer (P2P) network to distribute tokens over the exchange. Let torrent bring us together and share an adventure into the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06d7b082-1ca5-452d-9334-6d9aec8dea34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

