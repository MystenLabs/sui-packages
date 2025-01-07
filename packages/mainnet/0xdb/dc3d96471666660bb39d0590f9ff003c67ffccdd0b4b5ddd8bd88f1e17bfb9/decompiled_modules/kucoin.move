module 0xdbdc3d96471666660bb39d0590f9ff003c67ffccdd0b4b5ddd8bd88f1e17bfb9::kucoin {
    struct KUCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUCOIN>(arg0, 9, b"KUCOIN", b"Kucoin", b"Coin ku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f73ba6b1-0758-4625-8d27-5138ad9962d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

