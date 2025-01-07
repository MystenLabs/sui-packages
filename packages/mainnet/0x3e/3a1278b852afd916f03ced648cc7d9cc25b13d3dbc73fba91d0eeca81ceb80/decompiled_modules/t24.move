module 0x3e3a1278b852afd916f03ced648cc7d9cc25b13d3dbc73fba91d0eeca81ceb80::t24 {
    struct T24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T24>(arg0, 6, b"T24", b"TrumpPump", b"The best currency that strongly supports the next American president, we vote together for truth, justice and strength", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/517_L5y_Gyi7_L_bd259f7617.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T24>>(v1);
    }

    // decompiled from Move bytecode v6
}

