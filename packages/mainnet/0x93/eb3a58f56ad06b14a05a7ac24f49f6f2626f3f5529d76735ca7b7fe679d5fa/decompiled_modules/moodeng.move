module 0x93eb3a58f56ad06b14a05a7ac24f49f6f2626f3f5529d76735ca7b7fe679d5fa::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"Moo Deng ", b"THE THAI ZOO HOME TO BABY HIPPO AND INTERNET SENSATION MOO DENG IS PATENTING THE PYGMY, Now on Sui ready to reach $billions in MC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f30eb839-36ed-483b-be07-b0c3705cf26d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

