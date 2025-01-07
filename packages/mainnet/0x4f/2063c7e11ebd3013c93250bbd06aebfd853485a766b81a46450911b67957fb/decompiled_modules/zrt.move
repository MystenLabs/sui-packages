module 0x4f2063c7e11ebd3013c93250bbd06aebfd853485a766b81a46450911b67957fb::zrt {
    struct ZRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZRT>(arg0, 9, b"ZRT", b"ZeroTwo", b"Otaku save the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4fa51b85-8690-45f4-9ecc-6bb381e07b9d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

