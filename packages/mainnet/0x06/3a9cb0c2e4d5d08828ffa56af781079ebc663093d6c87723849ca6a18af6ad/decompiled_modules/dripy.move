module 0x63a9cb0c2e4d5d08828ffa56af781079ebc663093d6c87723849ca6a18af6ad::dripy {
    struct DRIPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPY>(arg0, 9, b"DRIPY", b"DripMokey", x"4865e280997320676f74207a65726f207574696c6974792c20313030252076696265732c20616e642066756c6c2d626c6f776e20636f6d6d756e697479207370697269742e20447269704d6f6b657920646f65736ee28099742063686173652063686172747320e28094206865207377696e6773207468726f75676820537569207769746820737761676765722c206f6e65206d656d6520617420612074696d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7b9f28c77a86363f9aeb3c9a9e606f05blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRIPY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

