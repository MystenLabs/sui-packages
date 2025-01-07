module 0x68108b2f4532fccc4a76e9b4449cd9f314c106f417523fc941c930eebc43bf81::sr {
    struct SR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SR>(arg0, 6, b"SR", b"SUIRRARI", b"Get ready for a thrilling experience with suirarri. Ape in and become a owner of a SuiRrari  sui luxury token made for the elite ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004224_1847d0edb9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SR>>(v1);
    }

    // decompiled from Move bytecode v6
}

