module 0xc158db0f900d4d8f9922987d4d514a83ebfb40a58141f255f0ee68590772824e::bom {
    struct BOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOM>(arg0, 6, b"BOM", b"BOMBIE TOKEN", x"53757276697665207468652041706f63616c797073652c2041697264726f70206973204b657921200a4578706c6f7265206162616e646f6e6564206369746965732c20756e636f766572206d7973746572696f75732041697264726f702c20616e64206765617220757020746f207468652074656574682120596f75206172652074686520736176696f7220696e207468652061706f63616c7970736521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bomb_7e6ee2d4ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

