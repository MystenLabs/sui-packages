module 0x394ed2b48506c235f7474104036344e39739b39af1387696bd9ff4b9fd7ac07c::dana {
    struct DANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANA>(arg0, 6, b"DANA", b"DANAs girls", b"The wife of $RAY ROMA is comming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tulo_1aa810d193.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

