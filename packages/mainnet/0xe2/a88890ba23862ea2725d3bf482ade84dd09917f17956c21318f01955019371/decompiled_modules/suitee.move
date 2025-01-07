module 0xe2a88890ba23862ea2725d3bf482ade84dd09917f17956c21318f01955019371::suitee {
    struct SUITEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEE>(arg0, 6, b"SUITEE", b"Suitee The Dog", b"The Suitest Dog On Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_13_at_1_59_40_PM_88cd6f3d5e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

