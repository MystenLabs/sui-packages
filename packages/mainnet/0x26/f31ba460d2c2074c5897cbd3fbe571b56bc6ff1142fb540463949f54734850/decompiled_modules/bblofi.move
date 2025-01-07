module 0x26f31ba460d2c2074c5897cbd3fbe571b56bc6ff1142fb540463949f54734850::bblofi {
    struct BBLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLOFI>(arg0, 6, b"BBLOFI", b"baby lofi", b"Yeti's always stick together on Sui. Welcome the new member of the Lofi family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5125462874553167014_f59707b5af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBLOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

