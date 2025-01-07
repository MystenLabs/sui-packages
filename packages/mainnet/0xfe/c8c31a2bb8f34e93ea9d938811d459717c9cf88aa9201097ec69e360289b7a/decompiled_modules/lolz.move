module 0xfec8c31a2bb8f34e93ea9d938811d459717c9cf88aa9201097ec69e360289b7a::lolz {
    struct LOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLZ>(arg0, 9, b"LOLZ", b"LOLZ COIN", b"LOLZ is the ultimate meme coin designed for fun and laughter in the crypto space!Get ready to LOL with your investment!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/458f528d-6513-4dbe-a8f5-87e568789050.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

