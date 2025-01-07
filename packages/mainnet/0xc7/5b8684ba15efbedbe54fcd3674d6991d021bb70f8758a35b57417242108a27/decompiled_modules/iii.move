module 0xc75b8684ba15efbedbe54fcd3674d6991d021bb70f8758a35b57417242108a27::iii {
    struct III has drop {
        dummy_field: bool,
    }

    fun init(arg0: III, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<III>(arg0, 6, b"III", b"III on SUI", b"This tikin midi fir fin, i cin inly siy ( i ) in my wird im sirry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/iii_2_102216bbe4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<III>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<III>>(v1);
    }

    // decompiled from Move bytecode v6
}

