module 0xd7863b3f3c950d7d9dd7632a107b65cda6d602bfb3774fc0c9019e00fd1270e8::vnd {
    struct VND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VND>(arg0, 6, b"VND", b"Vundio", x"48692056756e2046616d7320210a4d616e61676520796f7572436f6c6c65637469626c6573206f6e206d6f766570756d700a56756e204d61726b6574706c6163652068617320616e204e465420636f6c6c656374696f6e20616e642077696c6c20616c736f206d616b652069742065617369657220666f7220796f7520746f206d616e616765204e465420636f6c6c65637469626c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vundio_sui_logo_2_cd38babf83.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VND>>(v1);
    }

    // decompiled from Move bytecode v6
}

