module 0x3b5c61a5594c693a22e26885c9f71449df2c11adfa06486d6a492d65e097cfe::niggatue {
    struct NIGGATUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGATUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGATUE>(arg0, 6, b"NIGGATUE", b"Nigga Pepe Statue", x"5765207370656e7420342064617973207363756c7074696e6720746865204e696767612050657065205374617475652c207475726e696e6720697420696e746f206d6f7265207468616e206a7573742061206d656d652e204974277320612073796d626f6c2e20244e4947474154554520697320686572652c20746f20676574206261636b6564206279206120636f6d6d756e69747920746861742063656c656272617465732074686973206d617374657270696563652e204d61726c626f726f20696e2068616e642c20506570652773206c6567616379206c69766573206f6e2074686520537569204e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_5_f8ffcfd897.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGATUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGATUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

