module 0xfbe967c220345e355d98f36a5e565937e3fca8b14a91ac7cc9ffb710ebf4c8c7::frogking {
    struct FROGKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGKING>(arg0, 6, b"FrogKing", b"FrogKing on sui", b"@FrogKing_MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gpsx_Wl_g_400x400_b8cbbaca86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

