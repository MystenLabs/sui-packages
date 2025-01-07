module 0xc04c209ddc10afcd2cb5acdb2ca2ad4ebf7ce9ae8037ec54c14f8a1dd06b3c76::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SpaceCat", b"SpaceCat Coin ($SCAT) is a meme-fueled token that brings humor, community, and utility to the crypto space. Join the most paw-some token in the galaxy, where you can create, share, and enjoy memes, all while earning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCAT_TGS_4ro_wwk0lq_Fgw_SQF_47e0427001.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

