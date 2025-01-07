module 0x65df24a95bcf887f258b6de9057558a81319d9f8de0fc70ff6523d0a2cb31dc7::dogeos {
    struct DOGEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEOS>(arg0, 6, b"DOGEOS", b"D.O.G.E", x"4465706172746d656e74206f6620676f7665726e6d656e74616c20656666696369656e6379206f6e205355492e0a4e6f7420616666696c6961746564207769746820444f47452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6895_cdc37e729e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

