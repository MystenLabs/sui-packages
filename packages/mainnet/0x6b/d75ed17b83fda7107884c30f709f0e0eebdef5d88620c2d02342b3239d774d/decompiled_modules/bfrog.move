module 0x6bd75ed17b83fda7107884c30f709f0e0eebdef5d88620c2d02342b3239d774d::bfrog {
    struct BFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFROG>(arg0, 6, b"BFROG", b"The Blue Frog", b"Blue Frog | The rarest frog on the block, bringing cool vibes and big leaps!  Hop into the world of fun, fortune, and frog-filled adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Ai6_Cky_GR_0_Vg_V_Gmi_Na7ww_30b518ebe3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

