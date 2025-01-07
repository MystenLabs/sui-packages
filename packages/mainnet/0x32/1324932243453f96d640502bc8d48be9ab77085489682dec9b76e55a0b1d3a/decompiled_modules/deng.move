module 0x321324932243453f96d640502bc8d48be9ab77085489682dec9b76e55a0b1d3a::deng {
    struct DENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENG>(arg0, 6, b"DENG", b"DENG SUI", b"$DENG on sui the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_17_15_09_ef67e94562.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

