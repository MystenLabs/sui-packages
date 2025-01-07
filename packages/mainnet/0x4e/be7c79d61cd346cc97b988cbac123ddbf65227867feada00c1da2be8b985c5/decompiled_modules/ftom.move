module 0x4ebe7c79d61cd346cc97b988cbac123ddbf65227867feada00c1da2be8b985c5::ftom {
    struct FTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTOM>(arg0, 6, b"FTOM", b"Funtom", x"46756e746f6d206973206120687962726964206d656d65207574696c69747920746f6b656e20776974682030207461782c2064657369676e656420666f722061207365616d6c65737320616e6420726577617264696e6720657870657269656e636520776974682069747320696e6e6f7661746976652065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726676077457_efcda7253f31e485dab8f6c8756fda62_5cbff29ae1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

