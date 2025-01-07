module 0xb03a90b3dac1cafbab1d0c4451548609acf0d1e7dfc6b6c8292a6c5362af7ff1::chong {
    struct CHONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONG>(arg0, 6, b"Chong", b"Evun Chong", x"4576756e2043686f6e672069732074686520446567656e206175746973746963206d656d652076657273696f6e206f6620436f2d466f756e64657220616e642043454f206f66204d797374656e204c61627320616e642043726561746f72206f6620537569204e6574776f726b204576616e204368656e672e20404576616e77656233206f6e20582e0a0a4a6f696e207573206f6e207468697320646567656e6572617465206a6f75726e657920746f20746865206d6f6f6e207769746820746865206d6f737420696d706f7274616e7420706572736f6e20696e2072656c6174696f6e20746f205355492e202443686f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb89607927d95e2bc897ef4f41d21605e4e6f237bf3b5c5c05b38c2e3f3f0221f_chong_chong_33ec0b8a3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

