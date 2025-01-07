module 0x12165870e764fbf714199312ee6b2008db52013e8a8359e8ed575bba0b395a83::sbubl {
    struct SBUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUBL>(arg0, 6, b"SBUBL", b"bublsui", x"427562626c696e67206f6e200a405375694e6574776f726b0a20746f206d616b65206672656e732e20436f6d696e6720736f6f6e206f6e20687474703a2f2f686f702e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BUBL_fe50ff2878.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

