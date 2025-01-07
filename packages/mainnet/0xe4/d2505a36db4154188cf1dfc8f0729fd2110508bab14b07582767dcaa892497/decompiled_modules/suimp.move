module 0xe4d2505a36db4154188cf1dfc8f0729fd2110508bab14b07582767dcaa892497::suimp {
    struct SUIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMP>(arg0, 6, b"SUIMP", b"SUIMPanzee", x"41626f757420245355494d500a0a686520686173207761697465642061206c6f6e672074696d6520746f20636f6d65206f757420696e746f20746865206f70656e2e2e2e20636f6d6520616e64206d65657420245355494d50207468652073696d70206368696d7020726561647920746f20726561636820746865206d6f6f6e20746f2065737461626c6973682068696d73656c66206173206f6666696369616c20535549206d6173636f747465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8105_b2b2bab290.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

