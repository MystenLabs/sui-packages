module 0x16c906e9bb962bac44d6066ddaa67360dcd9a2f48c9cfc8be704be2a5b01a84f::suide {
    struct SUIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDE>(arg0, 6, b"SUIDE", b"Suide The Cat", b"We love pixel cats on Sui! WE LOVE PIXEL CATS ON SUIIIIII!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_9_56_51_AM_b1dd0809e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

