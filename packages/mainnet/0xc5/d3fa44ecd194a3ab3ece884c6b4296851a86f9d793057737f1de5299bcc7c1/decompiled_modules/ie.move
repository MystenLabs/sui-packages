module 0xc5d3fa44ecd194a3ab3ece884c6b4296851a86f9d793057737f1de5299bcc7c1::ie {
    struct IE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IE>(arg0, 6, b"IE", b"Ice Eel", x"0a77686174206973204963652045656c3f0a4963652045656c20697320612066756e6e79206d656d65207468617420636f6d62696e65732074686520696d616765206f6620616e20656c6563747269632065656c20776974682074686520776f7264202269636520637265616d22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/05b_1_ff23e2c179.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IE>>(v1);
    }

    // decompiled from Move bytecode v6
}

