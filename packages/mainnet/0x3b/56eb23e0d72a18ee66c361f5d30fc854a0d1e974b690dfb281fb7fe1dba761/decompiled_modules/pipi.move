module 0x3b56eb23e0d72a18ee66c361f5d30fc854a0d1e974b690dfb281fb7fe1dba761::pipi {
    struct PIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPI>(arg0, 6, b"PIPI", b"Pipi  Pepe", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPI>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PIPI>>(v2);
    }

    // decompiled from Move bytecode v6
}

