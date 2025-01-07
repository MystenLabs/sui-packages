module 0x7c48c35b0341908ed67488da9230dbf69044931f77e89a00436eed402a6f1c15::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SpaceCat", b"SpaceCat Coin ($SCAT) is a meme-fueled token that brings humor, community, and utility to the crypto space. Join the most paw-some token in the galaxy, where you can create, share, and enjoy memes, all while earning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SCAT_TGS_4ro_wwk0lq_Fgw_SQF_1_f5ff2eb159.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

