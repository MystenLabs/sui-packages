module 0x6725a5c16d8b1d5516b5fb6e0536382de66ef593b46c17041b031f3ce2f67ac5::shmily {
    struct SHMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHMILY>(arg0, 9, b"SHMILY", b"CHZK", b"games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdb47d97-0291-4a88-b1c2-fde6e843b3e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

