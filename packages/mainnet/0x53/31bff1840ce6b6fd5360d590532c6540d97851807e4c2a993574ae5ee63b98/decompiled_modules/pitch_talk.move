module 0x5331bff1840ce6b6fd5360d590532c6540d97851807e4c2a993574ae5ee63b98::pitch_talk {
    struct PITCH_TALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITCH_TALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITCH_TALK>(arg0, 9, b"PITCH_TALK", b"PITCH", b"A token dedicated to the revolutionary meme coin PITCH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d159b56c-51b9-4ae1-81cf-4140bd7dca98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITCH_TALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PITCH_TALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

