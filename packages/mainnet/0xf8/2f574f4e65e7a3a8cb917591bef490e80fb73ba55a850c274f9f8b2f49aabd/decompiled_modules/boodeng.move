module 0xf82f574f4e65e7a3a8cb917591bef490e80fb73ba55a850c274f9f8b2f49aabd::boodeng {
    struct BOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOODENG>(arg0, 6, b"BOODENG", b"Sheep Gang", b"Flock and roll! When the whole squad decides it's nap time at the same time 111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sheep_At_Night_Look_Terrifying_fa546b8a29.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

