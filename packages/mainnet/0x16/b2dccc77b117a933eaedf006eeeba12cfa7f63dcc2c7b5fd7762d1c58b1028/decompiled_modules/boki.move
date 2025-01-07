module 0x16b2dccc77b117a933eaedf006eeeba12cfa7f63dcc2c7b5fd7762d1c58b1028::boki {
    struct BOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOKI>(arg0, 6, b"BOKI", b"Boki on Sui", b"BOKI IS a memoin on sui and will destroy the mass of existing memoins, it is bullish, let's give it an attack ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039695_f0f33fff70.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

