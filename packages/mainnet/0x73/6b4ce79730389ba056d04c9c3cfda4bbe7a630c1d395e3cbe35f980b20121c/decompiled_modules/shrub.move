module 0x736b4ce79730389ba056d04c9c3cfda4bbe7a630c1d395e3cbe35f980b20121c::shrub {
    struct SHRUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRUB>(arg0, 6, b"SHRUB", b"Shrub The Hedgehog", b"Elon's family newest pet $SHRUB.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731226896607.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

