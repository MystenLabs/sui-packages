module 0x128bf5b9bcda0c9565723918bdf20da16de59fcb0e0c17be1e7ab93ec345d9cf::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MAX", b"maxud78", b"MAX - will change the world)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a665b41f-1808-4055-b3e5-067b7443c987.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

