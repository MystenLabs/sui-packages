module 0xf6d06b483e1563a059954df6dfc2c6df713e3b0a76193b0cf557e621a591e63c::wal {
    struct WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL>(arg0, 6, b"WAL", b"Walrus Token", b"Wal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/36119_3f3241732b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

