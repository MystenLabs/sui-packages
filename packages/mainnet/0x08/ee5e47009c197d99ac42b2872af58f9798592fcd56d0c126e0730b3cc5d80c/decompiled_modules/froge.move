module 0x8ee5e47009c197d99ac42b2872af58f9798592fcd56d0c126e0730b3cc5d80c::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"FrogeCoin", x"5468652054616c65206f662061204e65772043727970746f204b696e673a20546865204269727468206f662046726f6765436f696e0a0a496e20746865206865617274206f6620746865206469676974616c20776f726c642c207768657265206d656d65732072756c656420616e64200a63727970746f63757272656e6369657320726569676e65642073757072656d652c2061206e6577206c6567656e64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_21_09_07_35_A_crypto_themed_banner_featuring_the_fusion_character_from_the_user_provided_image_The_character_stands_in_the_center_surrounded_by_floating_golden_9f81379f90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

