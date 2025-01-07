module 0x364caf14d9001b7c87523811179586310ba47f7b8d24db1e6fbfdbe033ebb16c::mongi {
    struct MONGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGI>(arg0, 6, b"Mongi", b"test", b"testtest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731255668932.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONGI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

