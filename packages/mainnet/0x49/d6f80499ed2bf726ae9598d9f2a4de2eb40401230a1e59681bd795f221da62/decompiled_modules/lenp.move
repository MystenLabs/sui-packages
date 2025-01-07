module 0x49d6f80499ed2bf726ae9598d9f2a4de2eb40401230a1e59681bd795f221da62::lenp {
    struct LENP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LENP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LENP>(arg0, 6, b"LENP", b"Len Peppeman", b"Len Peppeman God Of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_22_14_51_38e434d145.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LENP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LENP>>(v1);
    }

    // decompiled from Move bytecode v6
}

