module 0x3c412d8c37fb814221554f28673d991fdd59b32f92a7f874e2addd82d4eec473::boat {
    struct BOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOAT>(arg0, 6, b"BOAT", b"Paper Boat Coin", x"566f796167696e6720746f20612042696c6c696f6e20446f6c6c617220486172626f722e0a224368696c64686f6f64204d656d6f7269657322", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image03_ccc76d382d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

