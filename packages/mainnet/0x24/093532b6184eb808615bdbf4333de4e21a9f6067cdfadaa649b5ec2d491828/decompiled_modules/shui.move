module 0x24093532b6184eb808615bdbf4333de4e21a9f6067cdfadaa649b5ec2d491828::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", b"Shu", b"https://x.com/Shui_onsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/er_OX_0_mf_400x400_784692c1f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

