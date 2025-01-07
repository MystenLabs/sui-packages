module 0xe09d8480a7aa5bde803dc1b97dfcea6479a23282263061300669dabd831b9a65::sslime {
    struct SSLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSLIME>(arg0, 6, b"SSLIME", b"SUI Slime", x"434f4d4d554e4954592d4f574e4544207c20302520434142414c204f574e4552534849500a0a496e74726f647563696e672053534c494d453a207468652073717569736869657374206d656d65636f696e206f6e207468652053554920626c6f636b636861696e212020496620796f7527766520657665722077616e74656420746f20696e7665737420696e206120746f6b656e2074686174277320617320626f756e6379206173206120736c696d6520616e642061732066756e20617320612066616e7461737920616e696d6520616476656e747572652c206c6f6f6b206e6f206675727468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rimuru_tempest_17593_2c55dd5de4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

