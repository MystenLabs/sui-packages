module 0xb16e66bf54c31c907ffa1868def0efd41130d70b54980095b2809995b3e11d8f::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", b"peanut on sui", x"5065616e7574202d20244e55540a0a4c657427732063726561746520746865206d6f7374206c696b65642070686f746f206f662061207065616e757420696e20686f6e6f72206f6620504e55542074686520737175697272656c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_194914_663_421c5d7d90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

