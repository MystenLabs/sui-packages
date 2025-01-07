module 0x1e911afb471caa2c64405127b8a46bcfb4963773d3797302bc2e740bd6e98052::mors {
    struct MORS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORS>(arg0, 6, b"Mors", b"BLUE MORS", x"496e2063727970746f277320646565702077696e7465722c20776520736c65707420276e656174682074686520776176652c204d6f727320696e205375692c2073696c656e7420616e642062726176652e0a4e6f7720726561647920746f20726f61722c2066726f6d207468652064657074687320746f20746865206c696768742c20546f67657468657220776520726973652c207769746820756e69746564204d6f7273206d696768742e0a0a68747470733a2f2f742e6d652f6d6f72736f6e7375690a68747470733a2f2f782e636f6d2f4d6f72737375690a68747470733a2f2f6d6f72737375692e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3805_87b10c733c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORS>>(v1);
    }

    // decompiled from Move bytecode v6
}

