module 0xabd6114b105ac052dc7697621fd699948b9c4a362fbb60bc92d250d8a044aae4::fuxi {
    struct FUXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUXI>(arg0, 6, b"FUXI", b"FUXI DRAGON", b"FUXI DRAGON a legendary  cultural hero and demigod, symbolizing the connection to nature and the divine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CQG_3478f_400x400_6d981a1fa3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

