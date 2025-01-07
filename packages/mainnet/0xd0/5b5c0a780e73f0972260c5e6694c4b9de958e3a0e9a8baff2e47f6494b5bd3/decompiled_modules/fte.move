module 0xd05b5c0a780e73f0972260c5e6694c4b9de958e3a0e9a8baff2e47f6494b5bd3::fte {
    struct FTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTE>(arg0, 9, b"FTE", b"FreeToEarn", b"\"Free To Earn\" - a community fostering fairness, support, and growth. Join us to explore earning opportunities and collaborate with like-minded individuals. Welcome to a place where everyone can thrive!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64ea0d6d-b534-4d89-8526-dc45f8e784ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

