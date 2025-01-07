module 0x417918cbe8a1527beb757589858a76f3e1908c9771aaab3268b13bbd19bfed9::mbix {
    struct MBIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBIX>(arg0, 9, b"MBIX", b"MBIX Token", b"Binance Moonbix To MBIX Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01190469-2bbe-4cbb-92c0-a83432145477.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MBIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

