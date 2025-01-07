module 0xce3b6ebbbc3a7c6f69d96c231ca4489e31023b438bc12fa57e3d35e788a8d51b::levi {
    struct LEVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEVI>(arg0, 6, b"LEVI", b"LEVI SUI", x"0a4c455649206973206e6f74206a757374206120536561206d6f6e7374657220736865206c6f6f6b732063757465207768656e2069742773206e6967687420736865206163742061206e6f726d616c204c657669617468616e2c2073686520616374207363617279206b696c6c696e672070656f706c6520616e6420656174696e6720736e616b657320616e64206b696c6c696e67206c696f6e732e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_14_04_47_87d904be4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEVI>>(v1);
    }

    // decompiled from Move bytecode v6
}

