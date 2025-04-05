module 0x587c2ce4ef03dbffa0357edb1a744ac170dd1a2d1915649da09f3c3d6af44f18::ttfc {
    struct TTFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTFC>(arg0, 9, b"TTfc", b"tehhte", b"catu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2c06bea38ac95bd50a67d4ebd5bd0644blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTFC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTFC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

