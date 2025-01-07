module 0x859f640847c8421869a5c9ce74a2ffc6eba6bfc61630c4525d25c721e625d42f::mnk {
    struct MNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNK>(arg0, 6, b"Mnk", b"Monk", b"monk token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_08_27_at_8_53_34a_PM_e32490f994.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

