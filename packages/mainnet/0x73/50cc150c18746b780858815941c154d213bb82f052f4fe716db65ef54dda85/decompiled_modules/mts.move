module 0x7350cc150c18746b780858815941c154d213bb82f052f4fe716db65ef54dda85::mts {
    struct MTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTS>(arg0, 6, b"MTS", b"MINI TRUMP SUI", b"MINIAND INVADES AMERICA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_20_36_41_264ff056e4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

