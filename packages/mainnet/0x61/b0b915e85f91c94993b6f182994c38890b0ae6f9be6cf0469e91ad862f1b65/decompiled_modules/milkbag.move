module 0x61b0b915e85f91c94993b6f182994c38890b0ae6f9be6cf0469e91ad862f1b65::milkbag {
    struct MILKBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKBAG>(arg0, 6, b"MILKBAG", b"THEMILKBAG", b"Bringing a fresh and creamy twist to Solana! Join #MILKBAG the number one meme project! Ride the milky wayve to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xm_NK_Qxg_I_400x400_f59bb49700.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILKBAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

