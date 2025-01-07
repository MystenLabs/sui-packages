module 0x5e71fb4d72e47838d1bb13bb5357dc230318f0d25b5d64b5d38bc123e7bbc479::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"Moodeng", b"Ai Moo deng", x"4d6f6f64656e6720627574206d616b652069742041492c206b656570696e67206974277320636861726d20666f7265766572210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kszb5k_LA_400x400_21dbc11f07.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

