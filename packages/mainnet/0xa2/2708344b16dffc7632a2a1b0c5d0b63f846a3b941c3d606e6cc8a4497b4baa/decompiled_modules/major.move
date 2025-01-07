module 0xa22708344b16dffc7632a2a1b0c5d0b63f846a3b941c3d606e6cc8a4497b4baa::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 6, b"MAJOR", b"Major Frog", x"4e4153412069732061206d757264657265722e0a0a54686579206b696c6c656420612066726f67206174204e4153412057616c6c6f707320466c6967687420466163696c69747920696e2056697267696e6961206f6e205365707420362c2032303133207c2031313a323720702e6d2e204553540a0a20417474656e74696f6e20636f6d6d616e646572732e200a0a4e415341206973206e6f7420746f20626520747275737465642e200a4e65696c20776f756c646e2774206576656e207377656172206f6e20746865206269626c652e200a5768617420617265207468657920686964696e672061626f7574204d616a6f722046726f673f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731025920837.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

