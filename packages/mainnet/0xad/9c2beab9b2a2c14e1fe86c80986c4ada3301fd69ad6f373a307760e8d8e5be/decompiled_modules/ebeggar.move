module 0xad9c2beab9b2a2c14e1fe86c80986c4ada3301fd69ad6f373a307760e8d8e5be::ebeggar {
    struct EBEGGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBEGGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBEGGAR>(arg0, 6, b"eBeggar", b"BEG", x"496e206120776f726c64206f66206469616d6f6e642068616e647320616e642022776527726520616c6c20676f6e6e61206d616b65206974222c207765277265206865726520746f206b656570206974207265616c2e20536f6d6574696d65732c20796f75206a75737420676f747461206265672e0a0a244245472069736e2774206a75737420616e6f74686572206d656d65636f696e3b20697427732061206c6966657374796c6520666f72207468652063727970746f2d637572696f757320616e642074686520756e61706f6c6f6765746963616c6c792062726f6b652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mascot_Bcd_Ep80_C_dd535727da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBEGGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBEGGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

