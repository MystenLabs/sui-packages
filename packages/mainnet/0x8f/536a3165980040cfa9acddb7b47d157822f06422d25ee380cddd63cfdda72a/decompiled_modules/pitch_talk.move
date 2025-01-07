module 0x8f536a3165980040cfa9acddb7b47d157822f06422d25ee380cddd63cfdda72a::pitch_talk {
    struct PITCH_TALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITCH_TALK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITCH_TALK>(arg0, 9, b"PITCH_TALK", b"PITCH", b"A token dedicated to the revolutionary meme coin PITCH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/589022a4-2cde-4e3a-b016-a99b43eea3fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITCH_TALK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PITCH_TALK>>(v1);
    }

    // decompiled from Move bytecode v6
}

