module 0x86e88e25eac5ea1fe93eeac19fabc2dca0adcbf3e78140491f7d91efb259b77f::torobull {
    struct TOROBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOROBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOROBULL>(arg0, 6, b"TOROBULL", b"TORO THE BULL", x"544f524f205448452042554c4c0a596f757265206e6f772070617274206f6620746865206a6f75726e65796c6574732063686172676520616865616420616e64206d616b6520686973746f727920746f67657468657221200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9999_f166c01ba3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOROBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOROBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

