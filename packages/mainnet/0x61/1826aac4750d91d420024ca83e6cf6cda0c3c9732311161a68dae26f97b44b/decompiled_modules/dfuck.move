module 0x611826aac4750d91d420024ca83e6cf6cda0c3c9732311161a68dae26f97b44b::dfuck {
    struct DFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFUCK>(arg0, 6, b"DFUCK", b"DFUCKKKKKKKKK", b"duckfuck on Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730973400034.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

