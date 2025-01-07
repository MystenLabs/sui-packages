module 0xd76c806730d8222b33a9951add21b982f71144e502a97ddcc9614be1cf7ab057::catq {
    struct CATQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATQ>(arg0, 6, b"Catq", b"Quantum Cat", b"Catsq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dhdhh_d6bbef42ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

