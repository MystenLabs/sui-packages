module 0x6080610411261ac4c2a75d99a8f2eaaf58b8f14a2632f918cca1171ecbdd95ad::memecat {
    struct MEMECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECAT>(arg0, 9, b"MEMECAT", b"Lucarox", b"Le mejor meme del mundo mundial", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f42ee4b-d9dd-4be8-a0ae-b1e9e4fe2165.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

