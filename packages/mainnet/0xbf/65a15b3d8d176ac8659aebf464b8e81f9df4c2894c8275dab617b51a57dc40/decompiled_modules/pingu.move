module 0xbf65a15b3d8d176ac8659aebf464b8e81f9df4c2894c8275dab617b51a57dc40::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"PINGU", b"Pungu Sui", x"50696e6775436f696e277320676f616c2069732073696d706c653a206265636f6d6520746865206d656d6520636f696e20746861742065766572796f6e652074616c6b732061626f75742e204e6f20636f6d706c69636174656420706c616e73206f7220736572696f757320616d626974696f6e736a757374206120706c617966756c206a6f75726e657920746f20746865206d6f6f6e206675656c656420627920696e7465726e65742068756d6f7220616e6420636f6d6d756e697479207370697269742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001791_c4ac904237.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

