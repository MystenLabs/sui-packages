module 0x14d3a21e85e91b20c5450f82839f1eaaa5c58a57ab801da2c89a748a6b563cac::dfuck {
    struct DFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFUCK>(arg0, 6, b"DFUCK", b"DFuck On Sui", b"Dirty Duck On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730986922222.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

