module 0xba8a4c30a79dce847852a526257b524d1e00c8ab01bfdea5f26fed3b97d5c23c::pixelmodeng {
    struct PIXELMODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXELMODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXELMODENG>(arg0, 6, b"PIXELMODENG", b"PIXEL MODENG", x"4d656574204d6f6f2044656e672c207468652061646f7261626c65206261627920706978656c207079676d7920686970706f2077686f7320717569636b6c79206265636f6d652074686520535549206661766f7269746520616e696d616c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_16_19_ebdb758a6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXELMODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXELMODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

