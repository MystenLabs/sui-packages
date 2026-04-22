module 0x121893036fa09a5d21877ee2733d6277bb77dda170d323b058578780d63a303::sex {
    struct SEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX>(arg0, 6, b"SEX", b"SEX", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

