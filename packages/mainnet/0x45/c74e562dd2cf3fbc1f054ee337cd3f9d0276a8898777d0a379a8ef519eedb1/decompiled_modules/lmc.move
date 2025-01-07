module 0x45c74e562dd2cf3fbc1f054ee337cd3f9d0276a8898777d0a379a8ef519eedb1::lmc {
    struct LMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMC>(arg0, 6, b"LMC", b"Loli merry christmas", b"Happy Christmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_01_09_40_52_105a92cd4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

