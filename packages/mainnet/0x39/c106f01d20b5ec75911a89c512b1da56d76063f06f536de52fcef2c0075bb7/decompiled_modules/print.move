module 0x39c106f01d20b5ec75911a89c512b1da56d76063f06f536de52fcef2c0075bb7::print {
    struct PRINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINT>(arg0, 6, b"PRINT", b"PrinterAi", b"PrinterAI is designed to be a fair and transparent system that will benefit the defi community as a whole. We are committed to using a fair profit split between holders, development, and buybacks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8e952f8e_e1f9_4675_8e27_c11886b24e1c_0fa378b91e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

