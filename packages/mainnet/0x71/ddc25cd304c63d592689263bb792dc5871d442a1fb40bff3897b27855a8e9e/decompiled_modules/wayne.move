module 0x71ddc25cd304c63d592689263bb792dc5871d442a1fb40bff3897b27855a8e9e::wayne {
    struct WAYNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAYNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAYNE>(arg0, 6, b"WAYNE", b"WAYNE-ORACLE", b"Wayne is the oracle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_42_5893742b25.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAYNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

