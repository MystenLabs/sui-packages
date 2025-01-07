module 0x41a1ec3097adbb05ec819d2c094fbadc30f2cdcd535b71fdca14655ab3a35af4::mmeow {
    struct MMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEOW>(arg0, 6, b"MMEOW", b"Mellow Meow", x"4c6966657320746f6f2073686f727420746f207374726573732061626f7574206d61726b6574206469707320616e64206368617274732c2072696768743f20456e746572204d656c6c6f77204d656f772c20746865207075727272666563740a6d656d6520636f696e20746861747320616c6c2061626f75742073746179696e6720636f6f6c2c2063616c6d2c20616e6420636f6c6c65637465646a757374206c696b6520796f7572206661766f726974652066656c696e652061667465722061206269670a6d65616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004387_ff2cd45811.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

