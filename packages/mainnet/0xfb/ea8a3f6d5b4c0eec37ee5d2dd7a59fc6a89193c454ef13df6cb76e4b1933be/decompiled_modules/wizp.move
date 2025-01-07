module 0xfbea8a3f6d5b4c0eec37ee5d2dd7a59fc6a89193c454ef13df6cb76e4b1933be::wizp {
    struct WIZP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIZP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZP>(arg0, 6, b"Wizp", b"Wip", x"57697a617264207075673a200a576f6f6f6f6f7368206e6f7720796f7520617265207269636821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002138_d3d8437cc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIZP>>(v1);
    }

    // decompiled from Move bytecode v6
}

