module 0xdc6e2f3b0ea8ebd09e6cddbc229f8e92a806ad003517110ea700b3f622dfa0ab::sdr {
    struct SDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDR>(arg0, 6, b"SDR", b"STRATEGIC DOGE RESER", b"Strategic Doge Reserve is a new memecoin that leverages the popularity of the Strategic Bitcoin Reserve concept, quickly gaining massive attention.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731500747597.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

