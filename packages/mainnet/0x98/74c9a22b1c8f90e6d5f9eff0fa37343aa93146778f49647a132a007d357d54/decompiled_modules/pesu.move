module 0x9874c9a22b1c8f90e6d5f9eff0fa37343aa93146778f49647a132a007d357d54::pesu {
    struct PESU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESU>(arg0, 6, b"PESU", b"PEPE ON SUI", b"first PESU pepe on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_07_09_at_02_22_46_ae76f4a2cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESU>>(v1);
    }

    // decompiled from Move bytecode v6
}

