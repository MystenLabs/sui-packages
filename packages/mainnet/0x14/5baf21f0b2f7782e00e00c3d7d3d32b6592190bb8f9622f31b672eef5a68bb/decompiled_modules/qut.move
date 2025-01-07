module 0x145baf21f0b2f7782e00e00c3d7d3d32b6592190bb8f9622f31b672eef5a68bb::qut {
    struct QUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUT>(arg0, 6, b"Qut", b"Queen Troll", b"Just Trollin'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723460835181_d7c9c7e0ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

