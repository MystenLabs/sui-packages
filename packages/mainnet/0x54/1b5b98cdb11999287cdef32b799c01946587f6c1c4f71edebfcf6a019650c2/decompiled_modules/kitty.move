module 0x541b5b98cdb11999287cdef32b799c01946587f6c1c4f71edebfcf6a019650c2::kitty {
    struct KITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KITTY>(arg0, 6, b"KITTY", b"Kitty", b"The 1st Kitty on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_18559_8bde08cb1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

