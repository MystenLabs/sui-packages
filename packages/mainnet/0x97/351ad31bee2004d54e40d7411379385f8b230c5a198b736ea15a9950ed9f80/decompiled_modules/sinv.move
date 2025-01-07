module 0x97351ad31bee2004d54e40d7411379385f8b230c5a198b736ea15a9950ed9f80::sinv {
    struct SINV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINV>(arg0, 6, b"sINV", b"Invest Zone", x"496e76657374205a6f6e65202873494e56292020746865206d6f73742066756e20746f6b656e206f6e207468652053756920626c6f636b636861696e210a0a537570706f727465642062792066756e206c6f7665727320616e6420706f77657265642062792070757265206a6f792c20697427732063727970746f207769746820612074776973742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_06_18_15_15_A_stylized_image_of_a_character_resembling_a_humanoid_duck_inspired_by_the_SUI_token_The_duck_is_in_a_modern_apartment_with_a_scenic_ocean_view_hol_46f61e7a1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SINV>>(v1);
    }

    // decompiled from Move bytecode v6
}

