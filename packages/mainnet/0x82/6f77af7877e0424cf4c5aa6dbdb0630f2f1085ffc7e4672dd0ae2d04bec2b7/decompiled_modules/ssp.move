module 0x826f77af7877e0424cf4c5aa6dbdb0630f2f1085ffc7e4672dd0ae2d04bec2b7::ssp {
    struct SSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSP>(arg0, 6, b"SSP", b"SUISEAPIN", x"496e74726f647563696e67205375695365615370696e20546f6b656e2c2020636f6d62696e696e6720746865206578636974656d656e74206f66206d656d657320776974682074686520746872696c6c206f66206f6e6c696e652067616d696e672c206f66666572696e67206120756e6971756520616e642062756c6c6973682063727970746f20657870657269656e63652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8961_581ad0b59a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

