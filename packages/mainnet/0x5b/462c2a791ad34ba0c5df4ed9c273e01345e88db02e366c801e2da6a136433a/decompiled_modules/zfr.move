module 0x5b462c2a791ad34ba0c5df4ed9c273e01345e88db02e366c801e2da6a136433a::zfr {
    struct ZFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZFR>(arg0, 9, b"ZFR", b"Zfr", b"New meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c19e43b1-40b6-4e54-b49c-da5d84d193c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

