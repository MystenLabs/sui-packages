module 0x4c0019e062480c46e8369ea3d0db6cb9cf5fb460f9445a5e7dcbe7576d20584f::toalpha {
    struct TOALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOALPHA>(arg0, 9, b"TOALPHA", b"TORRENT", b"TORRENT is a meme inspired to sharing protocol that uses a peer-to-peer (P2P) network to distribute files over the internet. Let torrent bring us together and share an adventure into the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/74f41617-f41d-406e-b1c5-0ed98ca18b01.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

