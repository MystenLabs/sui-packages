module 0xc962185a63233bd4ed0e20d27b7b8b394b235318bee3f3631b831c7118693c30::lotl {
    struct LOTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOTL>(arg0, 6, b"LOTL", b"Axolotl", b"The first Axolotl on $Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_25_22_57_56_A_cute_cartoon_axolotl_with_large_expressive_eyes_and_a_wide_friendly_smile_The_axolotl_is_in_a_playful_and_energetic_pose_with_bright_and_soft_pa_ab76aaef4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

