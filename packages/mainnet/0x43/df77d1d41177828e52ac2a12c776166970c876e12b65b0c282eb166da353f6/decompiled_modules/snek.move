module 0x43df77d1d41177828e52ac2a12c776166970c876e12b65b0c282eb166da353f6::snek {
    struct SNEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEK>(arg0, 6, b"SNEK", b"Snek", b"Just a snek.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731116815072.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

