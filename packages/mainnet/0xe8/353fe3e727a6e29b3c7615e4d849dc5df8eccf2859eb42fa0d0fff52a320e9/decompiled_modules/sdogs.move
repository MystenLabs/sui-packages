module 0xe8353fe3e727a6e29b3c7615e4d849dc5df8eccf2859eb42fa0d0fff52a320e9::sdogs {
    struct SDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGS>(arg0, 9, b"SDOGS", b"suiDogs", b"Dogs on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bbb27fe-38d1-473f-82e2-8bbac7247e58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

