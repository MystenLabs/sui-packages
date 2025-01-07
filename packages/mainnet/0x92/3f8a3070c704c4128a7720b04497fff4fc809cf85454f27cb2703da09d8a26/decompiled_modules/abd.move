module 0x923f8a3070c704c4128a7720b04497fff4fc809cf85454f27cb2703da09d8a26::abd {
    struct ABD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABD>(arg0, 6, b"ABD", b"Angry bird", b"Angry bird ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241013_215744_871_c9d4436731_5a6afc6eca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABD>>(v1);
    }

    // decompiled from Move bytecode v6
}

