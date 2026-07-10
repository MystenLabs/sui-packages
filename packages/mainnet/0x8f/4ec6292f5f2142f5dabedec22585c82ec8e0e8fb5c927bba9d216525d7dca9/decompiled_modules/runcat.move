module 0x8f4ec6292f5f2142f5dabedec22585c82ec8e0e8fb5c927bba9d216525d7dca9::runcat {
    struct RUNCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNCAT>(arg0, 6, b"Runcat", b"Runcat Test", b"Test me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1783651147331.0384")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUNCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

