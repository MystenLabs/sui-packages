module 0x14ec7a4561bdeb19c88931fa8aa3953479d92f35a77244b6f8e695c6f7aa679b::sdg {
    struct SDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDG>(arg0, 9, b"SDG", b"Suidoge", b"\"SuiDoge\" is a new meme coin for cryptocurrency enthusiasts and meme lovers, built on the Sui network. It features unique functionalities for engaging with meme coins and draws design ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ff0d563f-4ebc-4631-b03d-b7a20307eb61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

