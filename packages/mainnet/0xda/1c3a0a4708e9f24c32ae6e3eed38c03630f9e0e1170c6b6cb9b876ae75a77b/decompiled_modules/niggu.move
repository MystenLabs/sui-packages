module 0xda1c3a0a4708e9f24c32ae6e3eed38c03630f9e0e1170c6b6cb9b876ae75a77b::niggu {
    struct NIGGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGU>(arg0, 6, b"NIGGU", b"Pudgy Niggu", x"4c657473207370696e207468652022626c6f636b22636861696e2c20696d6d6120736c696465206f6e204f72636120666f72206d79204f472050656e67750a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_152759_136_87122af017.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

