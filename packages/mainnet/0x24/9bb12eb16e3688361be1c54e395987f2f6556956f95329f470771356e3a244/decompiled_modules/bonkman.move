module 0x249bb12eb16e3688361be1c54e395987f2f6556956f95329f470771356e3a244::bonkman {
    struct BONKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKMAN>(arg0, 6, b"Bonkman", b"BonkmanSui", x"4865656c6c6f2c204920616d20426f6e6b6d616e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rv_Bk_D_Hrn_400x400_d20407441e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

