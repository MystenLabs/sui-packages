module 0x82f7e64f34c0ab82cb590fb3cd37e57f75bcdbc663c72298347ec8a4f3b8bf9b::gator {
    struct GATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATOR>(arg0, 6, b"Gator", b"Gator Sui", b"Some people say that the Aggrigator was born from the dream of a mad degen wizard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_01_02_at_11_34_16a_pm_85080bc67f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

