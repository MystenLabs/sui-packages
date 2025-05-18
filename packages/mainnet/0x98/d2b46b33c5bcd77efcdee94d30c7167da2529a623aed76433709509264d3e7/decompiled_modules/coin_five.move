module 0x98d2b46b33c5bcd77efcdee94d30c7167da2529a623aed76433709509264d3e7::coin_five {
    struct COIN_FIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_FIVE>(arg0, 9, b"coinfive", b"coin five", b"coin five desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/00653449-74a0-4c25-a2b9-50f177bfd09f.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_FIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_FIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

