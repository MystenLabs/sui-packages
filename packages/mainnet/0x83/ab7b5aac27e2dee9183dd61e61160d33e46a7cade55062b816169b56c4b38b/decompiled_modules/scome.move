module 0x83ab7b5aac27e2dee9183dd61e61160d33e46a7cade55062b816169b56c4b38b::scome {
    struct SCOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOME>(arg0, 6, b"SCOME", b"Sui Call Of Meme", x"5768657265206c7578757279206d65657473207468652076696272616e7420776f726c64206f66206d656d652063756c747572652c20626c656e64696e67206578636c7573697665207961636874696e672077697468207468652064796e616d696320737069726974206f66206d656d652d64726976656e20636f6d6d756e69747920656e676167656d656e742e20576520696e7669746520616c6c206d656d657320746f206a6f696e2074686520627573746c696e67205355492065636f73797374656d2c20636f6c6c6563746976656c7920666f7267696e6720746865207472656e6473206f6620706f702063756c747572652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/np_VH_Ezx_E_400x400_4cf3a4e701.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

