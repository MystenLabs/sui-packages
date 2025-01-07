module 0x117ed5fb945def055820222a918df5ca835144fbbae5284baabfd1943d5f3f07::suilen {
    struct SUILEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEN>(arg0, 6, b"SUILEN", b"LEN ON SUI CTO", b"In honour of Len Sassaman the immortal. RELAUNCH!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_21_13_03_f8d590bcad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

