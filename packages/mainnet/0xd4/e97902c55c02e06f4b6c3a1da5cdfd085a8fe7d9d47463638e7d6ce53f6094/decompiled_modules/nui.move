module 0xd4e97902c55c02e06f4b6c3a1da5cdfd085a8fe7d9d47463638e7d6ce53f6094::nui {
    struct NUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUI>(arg0, 6, b"NUI", b"Notsui", b"Probably suithing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FBFE_5_C5_B_8_F85_4452_BD_76_9981719_A4_B8_D_9c044e8ff9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

