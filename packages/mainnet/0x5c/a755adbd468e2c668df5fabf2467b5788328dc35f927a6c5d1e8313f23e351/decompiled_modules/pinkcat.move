module 0x5ca755adbd468e2c668df5fabf2467b5788328dc35f927a6c5d1e8313f23e351::pinkcat {
    struct PINKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKCAT>(arg0, 9, b"PINKCAT", b"PinkCat", b"Pink Cat is a meme coin on the SUI Chain, designed to bring fun, excitement, and community-driven growth to the world of cryptocurrencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be70f4b2-d230-452f-add3-f83a33e101e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

