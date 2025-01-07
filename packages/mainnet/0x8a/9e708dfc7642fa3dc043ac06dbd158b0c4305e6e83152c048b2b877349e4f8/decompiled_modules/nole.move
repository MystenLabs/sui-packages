module 0x8a9e708dfc7642fa3dc043ac06dbd158b0c4305e6e83152c048b2b877349e4f8::nole {
    struct NOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOLE>(arg0, 6, b"NOLE", b"NOLE on SUI", b"NOLE is the first Reversed Elon on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nolejr_7eba1c6957.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

