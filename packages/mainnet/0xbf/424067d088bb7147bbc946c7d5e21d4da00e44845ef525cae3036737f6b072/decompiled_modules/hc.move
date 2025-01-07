module 0xbf424067d088bb7147bbc946c7d5e21d4da00e44845ef525cae3036737f6b072::hc {
    struct HC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HC>(arg0, 6, b"HC", b"HopCat", x"48692c2049276d20486f702c2074686520636f6f6c657374206361740a6f6e2073756921205965732c2049276d206c696b652074686174202d20490a6a756d70206c696b652061207265616c206174686c6574652c206f720a616c6d6f73742e2e2e20427574206576657279206a756d7020490a6d616b6520697320612073686f772120416c736f2c0a6265747765656e20796f7520616e64206d652c2049206c6f766520746f0a65617420666973682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5502_59de9f6279.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HC>>(v1);
    }

    // decompiled from Move bytecode v6
}

