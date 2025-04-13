module 0x326f73a45458b5160dd14129f798175b05eac921f7601278458e8ee782125597::dogtongue {
    struct DOGTONGUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTONGUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTONGUE>(arg0, 6, b"DOGTONGUE", b"Dogtongue", x"4865792066616d2c206c6574277320737469636b206f757420796f757220746f6e67756520776974682024444f47544f4e4755450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057248_638c261b31.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTONGUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTONGUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

