module 0xb4d6fe9b1fbcc0ae28a2db4e6adb42dabf0b8d2708303c85e2b67ed4e7805a08::eld {
    struct ELD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELD>(arg0, 6, b"ELD", b"Elon Deng", b"a meme coin inspired by Moodeng (the now famous bouncing Pygmy Hippo) featuring the head of Elon Musk and called Elondeng (bouncing Elon). A new creature Combining Moodeng and Musk's recent bouncing stunts on stage during a Trump rally and his signat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960564450.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

