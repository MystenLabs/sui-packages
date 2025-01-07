module 0x81ffe315245466645fc9f9f474c57e2a3bf2c20766a05e2c758c9560d30d5515::wlf {
    struct WLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLF>(arg0, 6, b"WLF", b"Woman life freedom", x"2e54686520776f726c64206e65656473207374726f6e6720776f6d656e0a0a576f6d656e2077686f2077696c6c206c69667420616e64206275696c64206f74686572732c2077686f2077696c6c206c6f766520616e64206265206c6f7665642c20776f6d656e2077686f206c6976652062726176656c792c20626f74682074656e64657220616e64206669657263652c20776f6d656e206f6620696e646f6d697461626c652077696c6c0a0a416d792054656e6e6579", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038723_6457e8e243.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

