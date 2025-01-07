module 0x839ffa0cffdf74b80d991cd6a164f1b0b41a4bf7f804852cf3cc1b9a3575f459::rhino {
    struct RHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINO>(arg0, 6, b"RHINO", b"Rhino Sui", b"RhinoSui: Built for strength, speed, and community on Sui | Charging toward a decentralized future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_24_10_29_45_A_cartoon_illustration_of_an_angry_rhino_similar_to_the_previous_one_with_its_head_lowered_and_eyes_glaring_as_if_it_s_about_to_charge_The_rhino_i_9e034fca56.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

