module 0x8b67210e688c4676e88fb70db644cfc30582fbb230c3cc792e619f17d66e9fb7::ost {
    struct OST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OST>(arg0, 6, b"OST", b"OnchainSuiTrump", b"MAGA MAGA MAGA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2503_553e63bc0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OST>>(v1);
    }

    // decompiled from Move bytecode v6
}

