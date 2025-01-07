module 0x8dc83c2dab6fa721354ac8cf1375fa1a185ab130d8b3c2e71dd3cf6eaf296c9c::supermoodeng {
    struct SUPERMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERMOODENG>(arg0, 6, b"SuperMooDeng", b"Super Moo Deng", b"Super Moo Deng is coming father!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o_Hk_ESO_6_E_400x400_5d88e53c1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERMOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

