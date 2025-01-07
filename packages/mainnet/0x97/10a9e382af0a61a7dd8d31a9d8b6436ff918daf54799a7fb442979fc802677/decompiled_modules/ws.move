module 0x9710a9e382af0a61a7dd8d31a9d8b6436ff918daf54799a7fb442979fc802677::ws {
    struct WS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WS>(arg0, 9, b"WS", b"WHITE SIDE", b"WHITE SIDE is a cutting-edge digital currency designed for a decentralized gaming ecosystem. It empowers players with seamless transactions, exclusive rewards, and a vibrant community, enhancing their gaming experience while ensuring security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/37b5d8e3-1768-42a0-a619-f7d4b3618abf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WS>>(v1);
    }

    // decompiled from Move bytecode v6
}

