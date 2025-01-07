module 0x3985d2c8b601a05b269372050c0adced06b71d5957367c37b4f19e1554a6d80a::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 6, b"PINK", b"PINK PANTHER", x"596f752073656520616e6420796f75206b6e6f772c2074686973206361742077696c6c206d616b65206120687567652073706c61736820696e207468697320706f6f6c2e2e2e0a4e6f206e6f206e6f2c2069742773206120636f6e737069726163792e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726327240657_a72f46dc57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

