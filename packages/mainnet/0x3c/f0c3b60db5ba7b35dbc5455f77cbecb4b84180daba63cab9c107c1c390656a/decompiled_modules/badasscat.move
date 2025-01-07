module 0x3cf0c3b60db5ba7b35dbc5455f77cbecb4b84180daba63cab9c107c1c390656a::badasscat {
    struct BADASSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADASSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADASSCAT>(arg0, 6, b"BADASSCAT", b"BADASSsuiCAT", b"A cat on SUI chain that is always planning for the next kill :) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_7afcf770c7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADASSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADASSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

