module 0xfde2ff3bcf50b991610dcb6ef89aabb20c7ece5c7242b00bdf4434aef7080e5e::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 6, b"EEVEE", b"Queen Eevee", x"f09f90be50726573656e74696e6720517565656e2045657665652c20746865206d616a657374696320746f6b656e206f6620726f79616c74792120f09f8c9f2043726f776e656420696e2070757265207361737320616e6420656c6567616e63652c20736865e28099732074686520707572722d666563742073796d626f6c206f6620637572696f736974792e20486f6c64696e6720244545564545206d65616e7320706c656467696e67206c6f79616c747920746f2066656c696e6520726f79616c747920e28093206a6f696e20746865206b696e67646f6d2c20616e6420756e6c6561736820796f757220696e6e65722063617420717565656e2120f09f9191f09f929c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731083104971.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EEVEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

