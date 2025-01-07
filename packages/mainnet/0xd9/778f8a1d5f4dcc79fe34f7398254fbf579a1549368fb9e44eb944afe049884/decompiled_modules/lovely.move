module 0xd9778f8a1d5f4dcc79fe34f7398254fbf579a1549368fb9e44eb944afe049884::lovely {
    struct LOVELY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVELY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVELY>(arg0, 6, b"LOVELY", b"LOVELY SUI", b"FOR BUILD IN LOVE SUI COMMUNITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/png_clipart_heart_light_blue_sky_blue_blue_hearts_s_love_blue_6058114287.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVELY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVELY>>(v1);
    }

    // decompiled from Move bytecode v6
}

