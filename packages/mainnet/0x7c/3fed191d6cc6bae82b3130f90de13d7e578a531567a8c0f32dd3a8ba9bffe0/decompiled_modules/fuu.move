module 0x7c3fed191d6cc6bae82b3130f90de13d7e578a531567a8c0f32dd3a8ba9bffe0::fuu {
    struct FUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUU>(arg0, 6, b"FUU", b"Something", x"536f6d657468696e672074726176656c65642066726f6d2074686520646570746873206f66207468652073756920736561206c6f6f6b696e6720666f7220465547202620424c55422c20465249454e44206f7220464f453f0a5468652053756920776f726c642077696c6c20736f6f6e2066696e64206f7574212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_123650291_1_1e59a3ae95.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

