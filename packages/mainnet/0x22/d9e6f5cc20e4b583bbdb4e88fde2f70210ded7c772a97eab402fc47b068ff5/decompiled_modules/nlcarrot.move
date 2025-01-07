module 0x22d9e6f5cc20e4b583bbdb4e88fde2f70210ded7c772a97eab402fc47b068ff5::nlcarrot {
    struct NLCARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NLCARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NLCARROT>(arg0, 6, b"NLCARROT", b"Next Leg Carrot", x"4d79206c656773206d6179206265207374756d70792c206275742049207374696c6c20636c696d622120536c6f7720616e64207374656164792077696e732074686520726163652074686579207361792e2057686f20697320726561647920746f2068656c70206d6520636c696d6220616c6c207468652077617920746f20746865206d6f6f6e3f210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_164511_242_bd3e03437d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NLCARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NLCARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

