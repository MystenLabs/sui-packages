module 0x229bb253174bbfe115f21e8fbdae05c4906143d2fb1b2ceb5c882f0b38926d2c::scoc {
    struct SCOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOC>(arg0, 6, b"SCOC", b"scarlet octopus", b"Scarlet Octopus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/564_57325d7823.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

