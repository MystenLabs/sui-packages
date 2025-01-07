module 0xb32323f834893ed0030aa98d8caba362207310acfadbcd08e5ea15e7aaf3d158::dildog {
    struct DILDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILDOG>(arg0, 6, b"DILDOG", b"Dilldog", b"Meet Pepes Pup! It's Dilldog! As Pepe's loyal new doggo and (slightly pickled) goodest boi, Dilldog brings a playful yet determined spirit to the blockchain. With his tangy twist and vinegar-laden bark, he's here to make waves in the meme-coin world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A5m_Kw9rpd_K_Js6g_Vj_e5ed315f76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

