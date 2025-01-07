module 0x199516c03458aa5a58f2838bff303a16ea48689a7a389f11c2d30e15b8a00260::suijelly {
    struct SUIJELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJELLY>(arg0, 6, b"SUIJELLY", b"Sui Jelly", b"SUIJELLY is the master of the deep Sui waters, floating through the Sui Network with electric precision. This jellyfish may look soft, but it stings with power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/umutcklc_cartoon_design_of_a_blue_jellyfish_funny_looking_vecto_a0d5ddf2_bc6e_4192_b69d_653b256148c9_aa02cd0435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

