module 0xf2bbf421ca5865d5ed6827702aab6f1fb737de4f95ea6d2643fbd3dbba57c3ca::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 6, b"SDRAG", b"SUI DRAGON", b"SuiDragon is a community-driven decentralized meme token with a dedicated team, pushing and developing behind the scenes to make this the biggest Grow coin of 2024!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Wd_Kju_EJ_400x400_cd6f3d6717.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

