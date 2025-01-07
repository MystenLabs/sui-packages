module 0xa1328a54a3423cd72bfde95e79bdbb6a8c39372349a88e575a867b2c726306bc::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XXX>(arg0, 6, b"XXX", b"SuiPlayXXX", x"4d454d45204f4620537569506c61793078310a585858207468652068616e6468656c64206669727374206f6e20776562332c20535549204e6574776f726b21204c6667", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xxx_c66e1e48bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

