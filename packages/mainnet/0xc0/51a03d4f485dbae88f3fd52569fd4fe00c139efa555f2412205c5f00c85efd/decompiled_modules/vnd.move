module 0xc051a03d4f485dbae88f3fd52569fd4fe00c139efa555f2412205c5f00c85efd::vnd {
    struct VND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VND>(arg0, 6, b"VND", b"VUNDIO", x"48692056756e2046616d7320210a4d616e61676520796f7572436f6c6c65637469626c6573206f6e204772612e46756e2028736f6f6e290a56756e204d61726b6574706c6163652068617320616e204e465420636f6c6c656374696f6e20616e642077696c6c20616c736f206d616b652069742065617369657220666f7220796f7520746f206d616e616765204e465420636f6c6c65637469626c65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_bb7b6615f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VND>>(v1);
    }

    // decompiled from Move bytecode v6
}

