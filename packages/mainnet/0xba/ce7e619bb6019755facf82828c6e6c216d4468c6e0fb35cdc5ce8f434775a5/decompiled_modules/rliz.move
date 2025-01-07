module 0xbace7e619bb6019755facf82828c6e6c216d4468c6e0fb35cdc5ce8f434775a5::rliz {
    struct RLIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RLIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RLIZ>(arg0, 6, b"RLIZ", b"RAINBOW LIZARD", b"Flashy, colorful, and impossible to ignore. Rainbow Lizard is climbing up the meme tree.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_040311853_886abc0f90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RLIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RLIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

