module 0x578d99264d3b2ee9e317656d9cf21d16c9bb7055d9da8c9a9c39fc5191df7673::pinkcat {
    struct PINKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKCAT>(arg0, 9, b"PINKCAT", b"PinkCat", b"Pink Cat is a meme coin on the SUI Chain, designed to bring fun, excitement, and community-driven growth to the world of cryptocurrencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5779571-018d-4076-8c39-2238d15fd4e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

