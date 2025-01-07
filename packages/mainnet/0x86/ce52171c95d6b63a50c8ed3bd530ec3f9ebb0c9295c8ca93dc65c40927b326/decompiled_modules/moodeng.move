module 0x86ce52171c95d6b63a50c8ed3bd530ec3f9ebb0c9295c8ca93dc65c40927b326::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"MOODENG ", b"Moo Deng to all challengers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/925d5b07-b6ff-44d9-9dfd-c8d21db290b8-1I9C2G0T7_319UA8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

