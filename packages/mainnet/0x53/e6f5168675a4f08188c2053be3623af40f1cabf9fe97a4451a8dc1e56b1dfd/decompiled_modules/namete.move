module 0x53e6f5168675a4f08188c2053be3623af40f1cabf9fe97a4451a8dc1e56b1dfd::namete {
    struct NAMETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMETE>(arg0, 6, b"NAMETE", b"TEST NAME", b"TEST NAME TEST NAME TEST NAME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1784019487986.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMETE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMETE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

