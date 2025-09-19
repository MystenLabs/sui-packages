module 0x4841c2db48d8c592644483b047d544cc576dea10f78af33c517cb2add4173878::HAX {
    struct HAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAX>(arg0, 9, b"HAX", b"HAX", b"HAX", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<HAX>>(0x2::coin::mint<HAX>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAX>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

