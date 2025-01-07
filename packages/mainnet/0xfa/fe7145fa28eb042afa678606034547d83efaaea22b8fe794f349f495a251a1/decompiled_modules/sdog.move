module 0xfafe7145fa28eb042afa678606034547d83efaaea22b8fe794f349f495a251a1::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 6, b"SDOG", b"SHIBDOG", x"53686962646f6720697320746865206e6577206d656d6520746861740a636865656b696c7920736e65616b73206f6e746f207468650a7468726f6e6573206f6620536869626120496e7520616e6420446f676521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003295_b63c73fccb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

