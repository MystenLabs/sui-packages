module 0x54e6e461dd0e0c2efd330ce7bc9d93991fd6d8acad95471616c02b344cbc7823::fake {
    struct FAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE>(arg0, 9, b"FAKE", b"DEEP", b"Deep fake token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34c40bc2-1441-481d-b532-d8fd796ce6d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

