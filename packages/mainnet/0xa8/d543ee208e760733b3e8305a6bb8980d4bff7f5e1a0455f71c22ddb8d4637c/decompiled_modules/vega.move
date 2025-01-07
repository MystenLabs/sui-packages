module 0xa8d543ee208e760733b3e8305a6bb8980d4bff7f5e1a0455f71c22ddb8d4637c::vega {
    struct VEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEGA>(arg0, 6, b"VEGA", b"VEGA Bear", b"VEGA means the brightest star on the universe and this cute bear amoung them .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000161632_576f618cb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

