module 0x4d104b469572bb27bf1c573ac2a921820465795348440fa9a81adefe3a44112d::labubu {
    struct LABUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABUBU>(arg0, 6, b"Labubu", b"Sui Labubu", b"Labubu memecoin  come to sui now, this memecoin will attract  more invester on sui and make it great sui memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aglabu_524e2c3c74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

