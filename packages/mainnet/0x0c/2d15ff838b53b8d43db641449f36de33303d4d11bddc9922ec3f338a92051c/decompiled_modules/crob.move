module 0xc2d15ff838b53b8d43db641449f36de33303d4d11bddc9922ec3f338a92051c::crob {
    struct CROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROB>(arg0, 6, b"CROB", b"SUICROB", x"43524f42206c6f766573206368696c6c696e672077697468206869732062726f73205045504520616e642042524554542c2062757420617420736f6d6520706f696e74207468657927726520646f6f6d656420746f206265636f6d6520686973206e657874206d65616c2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crob_363bfd2824.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

