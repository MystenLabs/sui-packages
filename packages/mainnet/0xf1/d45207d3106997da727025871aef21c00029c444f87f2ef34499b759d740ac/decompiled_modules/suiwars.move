module 0xf1d45207d3106997da727025871aef21c00029c444f87f2ef34499b759d740ac::suiwars {
    struct SUIWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWARS>(arg0, 6, b"SUIWARS", b"Sui Wars", b"May the pump be with you! RELAUNCHING ON TURBOS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731190808193.JPG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

