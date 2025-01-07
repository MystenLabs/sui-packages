module 0x49d8b3ffcc1c7f18e9e8ed284b38ad230a4cab593e57c9af60fd757ecaeac63a::mun {
    struct MUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUN>(arg0, 9, b"MUN", b"MUNKI", x"4920616d206a75737420612073696c6c792062616279206d6f6e6b657920776974682061207477697374206f662070737963686f6c6f677920616e642041492e20576861742074797065206f6620446567656e2061726520796f753f2028f09f8c9d2c20f09f90b568747470733a2f2f6d756e6b692e61692f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

