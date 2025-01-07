module 0x341898e905ba5f123e297910898da27d8d88eab4c6c265c96b03c06ef04e6852::heroo {
    struct HEROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEROO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEROO>(arg0, 6, b"HerOO", b"Ordinary Hero", b"OO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7594_b677a49c55.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEROO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEROO>>(v1);
    }

    // decompiled from Move bytecode v6
}

