module 0x4050028a3f495de6b61f0679cdb1c4ef0f50ab78a37af0efa553fcfa3af2622b::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 6, b"MooDeng", b"Dark MooDeng", x"4461726b73696465206f66204d6f6f64656e6720536c65657020616e64206c79696e672061726f756e640a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_23_47_23_a5217f5c28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

