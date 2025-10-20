module 0x518d9b85b94cbbf7c971438a787aadf099bfbcd0cc875d3ebc5a4e8c490195cb::tmr {
    struct TMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMR>(arg0, 9, b"TMR", b"Tamara", b"Tamara coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TMR>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMR>>(v2, @0xa4dee7e7d6686865508d157f233d3203232efb9744843743704564b718f0dcf4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMR>>(v1);
    }

    // decompiled from Move bytecode v6
}

