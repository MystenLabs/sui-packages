module 0x358b91f83fc33d7f085ff27e683146fa7be67c202328dba99a2be599a3536bb3::erf {
    struct ERF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ERF>(arg0, 6, b"ERF", b"erf by SuiAI", b"Erf: Your AI Guide to the Uncharted Corners of!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image2_696edd663c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ERF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

