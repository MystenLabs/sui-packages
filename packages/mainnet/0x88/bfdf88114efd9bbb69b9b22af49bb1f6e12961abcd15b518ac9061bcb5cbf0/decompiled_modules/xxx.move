module 0x88bfdf88114efd9bbb69b9b22af49bb1f6e12961abcd15b518ac9061bcb5cbf0::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX>(arg0, 6, b"XXX", b"axx", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_ef60ffdf36.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

