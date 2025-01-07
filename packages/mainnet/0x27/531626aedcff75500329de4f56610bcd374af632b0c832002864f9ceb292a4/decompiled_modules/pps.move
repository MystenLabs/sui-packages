module 0x27531626aedcff75500329de4f56610bcd374af632b0c832002864f9ceb292a4::pps {
    struct PPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPS>(arg0, 6, b"PPS", b"Popcat Sui", b"Popcat on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1131_8655c54f57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

