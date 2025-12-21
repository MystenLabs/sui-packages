module 0x96a12d02acdd474cde1b272b0b0cc31dde89cc4e0594f88df2c3d13f84f28188::hd {
    struct HD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HD>(arg0, 6, b"HD", b"Helpless dogs", b"Helped the homeless dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HD>>(v2, @0xbf08fd3466042d8beda9a5823e3d2fed3e6fcfe4fa7d83cf9e3c66938a999987);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HD>>(v1);
    }

    // decompiled from Move bytecode v6
}

