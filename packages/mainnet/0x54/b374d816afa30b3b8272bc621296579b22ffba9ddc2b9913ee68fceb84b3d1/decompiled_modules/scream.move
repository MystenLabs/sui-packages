module 0x54b374d816afa30b3b8272bc621296579b22ffba9ddc2b9913ee68fceb84b3d1::scream {
    struct SCREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAM>(arg0, 6, b"SCREAM", b"SCREAM The Meme", b"SCREAM THE MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Og_Mrr2_ZD_400x400_e5b0f9e5f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

