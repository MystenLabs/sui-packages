module 0x22a6ec1deb21fc3fc8d2c363cec7656205df1eb9bda7373e1d3065a06b050385::rqct {
    struct RQCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RQCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RQCT>(arg0, 9, b"RQCT", b"RageQuit Coin", x"4120746f6b656e20666f72206472616d617469632065786974732e204275726e2052514354207768656e206c656176696e672044414f732c207175697474696e67206a6f62732c206f7220726167652d756e7375627363726962696e672066726f6d206e6577736c6574746572732e20436f6d657320776974682068696c6172696f7573204e465420636572746966696361746573206f66206465706172747572652e20476f6f646279652c20627574206f6e2d636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0357b59e0344dfdce46271c60a0917d8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RQCT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RQCT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

