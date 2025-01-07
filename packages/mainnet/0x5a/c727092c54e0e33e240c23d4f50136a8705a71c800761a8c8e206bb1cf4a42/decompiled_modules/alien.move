module 0x5ac727092c54e0e33e240c23d4f50136a8705a71c800761a8c8e206bb1cf4a42::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"ALIEN", b"ALIEN AI", x"57656c636f6d6520746f20666f6c6c6f7720746865206f6666696369616c20416c69656e206163636f756e742e204c6574277320737570706f727420746865736520617373686f6c657320746f676574686572210a23414c49454e206973206f6e6c696e650a40535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fb84yg_Pf_400x400_b67b68f12d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

