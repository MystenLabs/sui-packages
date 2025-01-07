module 0x36a5884dc9156db346bb7a93e995d553967e9f32d667c2ab81baa0fc116a953a::quantboy {
    struct QUANTBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANTBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTBOY>(arg0, 6, b"QUANTBOY", b"Quant Boy", b"Quantboy on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732110592862.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANTBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANTBOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

