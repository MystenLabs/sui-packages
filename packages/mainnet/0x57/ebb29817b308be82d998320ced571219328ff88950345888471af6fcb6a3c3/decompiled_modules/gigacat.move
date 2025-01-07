module 0x57ebb29817b308be82d998320ced571219328ff88950345888471af6fcb6a3c3::gigacat {
    struct GIGACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACAT>(arg0, 6, b"GIGACAT", b"GIGA CAT", b"Step aside fellow cats... GIGA CAT has arrived!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/222_00c8fc8f58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

