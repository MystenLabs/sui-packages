module 0x75923474a92e8227b4715bed36c2d6b929cb97fe4116fbc3c32708e45e970e34::bneire {
    struct BNEIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNEIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNEIRE>(arg0, 6, b"BNEIRE", b"Bullioner", x"2042756c6c696f6e6169726520436f696e207c20204d656d65636f696e20776974682061206c75787572792074776973740a204578636c75736976652041697264726f7073207c2020556e69717565204e4654730a2052696465207468652042756c6c2052756e207c20204a6f696e2074686520436f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul18_20241216183714_b8b9f5c2b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNEIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNEIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

