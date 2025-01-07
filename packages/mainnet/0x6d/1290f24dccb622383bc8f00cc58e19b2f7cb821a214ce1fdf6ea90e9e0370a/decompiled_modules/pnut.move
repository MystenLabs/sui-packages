module 0x6d1290f24dccb622383bc8f00cc58e19b2f7cb821a214ce1fdf6ea90e9e0370a::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut the Squirrel", b"Its our job to help save peanut the squirrel! Sign the petition!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018092_fc2354beb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

