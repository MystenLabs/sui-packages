module 0xc990268699bb95dc6353ce9654284fb693ee68f651d0e2cc0db354852fcc068f::suiy {
    struct SUIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIY>(arg0, 6, b"SUIY", b"Suzy Seahorse", b"Ridin the waves of the Sui chain, Dive in and ride the tide with the swiftest sea horse of the sea, Suzy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_22_52_22_5e6136d6dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

