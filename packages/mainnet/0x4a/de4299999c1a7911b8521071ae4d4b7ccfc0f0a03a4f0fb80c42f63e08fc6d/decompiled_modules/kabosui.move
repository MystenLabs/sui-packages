module 0x4ade4299999c1a7911b8521071ae4d4b7ccfc0f0a03a4f0fb80c42f63e08fc6d::kabosui {
    struct KABOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KABOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KABOSUI>(arg0, 6, b"KABOSUI", b"KABOSU ON SUI", b"KABOSU ON SUI is UNSTOPPABLE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_KA_4_u_HK_400x400_3fb5f771e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KABOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KABOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

