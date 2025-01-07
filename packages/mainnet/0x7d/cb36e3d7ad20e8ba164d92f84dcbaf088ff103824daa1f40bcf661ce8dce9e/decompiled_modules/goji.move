module 0x7dcb36e3d7ad20e8ba164d92f84dcbaf088ff103824daa1f40bcf661ce8dce9e::goji {
    struct GOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOJI>(arg0, 6, b"GOJI", b"Goji", b"Hi i'm Goji! A sui memecoin focused on COMMUNITY, ART. I aim to be the biggest and most recognized memecoin on the internet!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_fcfca15dcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

