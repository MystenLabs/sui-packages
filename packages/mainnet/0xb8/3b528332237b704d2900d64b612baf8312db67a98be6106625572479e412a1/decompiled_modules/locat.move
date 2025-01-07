module 0xb83b528332237b704d2900d64b612baf8312db67a98be6106625572479e412a1::locat {
    struct LOCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCAT>(arg0, 6, b"LOCAT", b"Loading Cat", b"Loading Cat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/loading_cat_80ce0c44c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

