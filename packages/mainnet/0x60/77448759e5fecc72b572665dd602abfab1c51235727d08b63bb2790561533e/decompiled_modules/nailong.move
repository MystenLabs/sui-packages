module 0x6077448759e5fecc72b572665dd602abfab1c51235727d08b63bb2790561533e::nailong {
    struct NAILONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAILONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAILONG>(arg0, 6, b"NAILONG", b"Nailong On Sui", x"4e61696c6f6e67204f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme3_1d3fe13ef7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAILONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAILONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

