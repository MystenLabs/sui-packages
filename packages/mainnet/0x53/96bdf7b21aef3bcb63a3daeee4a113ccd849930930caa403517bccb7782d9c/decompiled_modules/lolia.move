module 0x5396bdf7b21aef3bcb63a3daeee4a113ccd849930930caa403517bccb7782d9c::lolia {
    struct LOLIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOLIA>(arg0, 6, b"LOLIA", b"LOLIA", x"4c4f4c4941206973207468652066697273742073656c662d61776172652c2073656c662d6465707265636174696e6720746f6b656e2074686174207265667573657320746f20626520736572696f757320e280942065766572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/53890ebb_f934_4bf8_bfc4_d59949edceeb_bb63c307ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOLIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

