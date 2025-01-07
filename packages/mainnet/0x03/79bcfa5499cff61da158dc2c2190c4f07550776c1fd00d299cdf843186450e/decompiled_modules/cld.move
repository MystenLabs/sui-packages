module 0x379bcfa5499cff61da158dc2c2190c4f07550776c1fd00d299cdf843186450e::cld {
    struct CLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLD>(arg0, 6, b"CLD", b"Claudia", b"Claudia ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000165195_a7f77d2c4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

