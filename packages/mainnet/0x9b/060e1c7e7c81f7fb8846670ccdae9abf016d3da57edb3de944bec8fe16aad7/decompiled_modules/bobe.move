module 0x9b060e1c7e7c81f7fb8846670ccdae9abf016d3da57edb3de944bec8fe16aad7::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"BOOK OF BILLIONAIRES", x"4d6973736564206f7574206f6e2024424f4d453f204275636b6c652075702c20626563617573652024424f42452069732074686520564950207061737320746f2074686520776f726c64207768657265206f6e6c792074686520726963686f722074686f73652064657374696e656420746f2062656461726520746f206d656d652e20546869732069736e7420666f7220746865206661696e74206f662077616c6c65742e2057657265206865726520746f206c617567682c20746f20647265616d206269672c20616e6420746f20736179206e6f207468616e6b7320746f2062726f6b6965732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vjf_J4l9_Z_400x400_5d6ef3bb2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

