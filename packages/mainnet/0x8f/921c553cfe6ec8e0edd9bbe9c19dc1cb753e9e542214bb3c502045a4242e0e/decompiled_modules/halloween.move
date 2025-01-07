module 0x8f921c553cfe6ec8e0edd9bbe9c19dc1cb753e9e542214bb3c502045a4242e0e::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 9, b"HALLOWEEN", b"Halloween", b"HALLOWEEN Coin is a Meme coin, released on SUI blockchain with inspiration and main image from the HALLOWEEN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/016ab743-d5e2-4483-bf8a-8aebea3fb2b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

