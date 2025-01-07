module 0xe14263caafe26aea9bd5146f39fee44698511cef330c9ee4f559b1e9b17819cc::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLM>(arg0, 6, b"BLM", b"BLUMSUI", b"Blumsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000345562_8506e25029.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

