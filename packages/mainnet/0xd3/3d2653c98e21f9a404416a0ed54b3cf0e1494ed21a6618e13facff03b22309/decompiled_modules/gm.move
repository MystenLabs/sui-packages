module 0xd33d2653c98e21f9a404416a0ed54b3cf0e1494ed21a6618e13facff03b22309::gm {
    struct GM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GM>(arg0, 6, b"GM", b"($GOLD)MAGNET", x"476f6c64206d61676e657420746f6b656e7320617265206f6674656e206173736f636961746564207769746820766172696f7573206c6f79616c74792070726f6772616d732c2067616d65732c206f72206469676974616c20617373657473207468617420616c6c6f7720757365727320746f206561726e2072657761726473206f7220626f6e757365732e0a54656c656772616d3a2068747470733a2f2f742e6d652f474f4c444d41474e45545355490a547769747465723a202068747470733a2f2f782e636f6d2f676d7375696e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_12_42_35_641edc3dc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GM>>(v1);
    }

    // decompiled from Move bytecode v6
}

