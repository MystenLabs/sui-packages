module 0xe54dc5e42ab8e6d94896b5b50b503eb7ed2b049e63382bc60dc4b10079a213f5::adafa {
    struct ADAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAFA>(arg0, 6, b"ADAFA", b"aefa", b"fafa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f6c5f68205539c140f2bf82bc7df08b8_0b0f926606.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

