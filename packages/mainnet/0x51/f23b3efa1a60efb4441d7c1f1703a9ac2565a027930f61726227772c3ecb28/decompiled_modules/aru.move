module 0x51f23b3efa1a60efb4441d7c1f1703a9ac2565a027930f61726227772c3ecb28::aru {
    struct ARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARU>(arg0, 9, b"ARU", b"AUR", b"URA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a186dd85-2a3d-42a8-b945-bfb570c5426e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

