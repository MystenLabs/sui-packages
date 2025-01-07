module 0xa298d017971ee77be26cab5a59b27a045833c382467abe9eb4e04076b5d7bff6::boo {
    struct BOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOO>(arg0, 9, b"BOO", b"UREI", b"UREI, the playful ghost born from countless meme coins, flows like water through the SUI chain. Stylish, cheeky, and just here for a bit of fun. Ride the wave and see where it takes you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54cef25e-20db-4201-a46d-6bba900a57be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

