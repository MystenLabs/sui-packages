module 0x74d69b521a7b8967dc842baa76f8215ac0cf9b178d8ad6dce19d9556a44cafa1::ffghj {
    struct FFGHJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFGHJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFGHJ>(arg0, 6, b"FFGHJ", b"Testd", b"FFFFFFFFFFFFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unknown_0d9e3ac0a5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFGHJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFGHJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

