module 0x48b7cc593b952d86bcbf4adf4142036604ef5e664ff235df96f0c740698516d0::scrooge {
    struct SCROOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCROOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCROOGE>(arg0, 6, b"SCROOGE", b"SCROOGE MCDUCK", b"I`m Scrooge McDuck, Manufactor, Shipper, Retailer, Financier, Bill Collector  anything in finance, I`m it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/235_1_c6e6be3169.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCROOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCROOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

