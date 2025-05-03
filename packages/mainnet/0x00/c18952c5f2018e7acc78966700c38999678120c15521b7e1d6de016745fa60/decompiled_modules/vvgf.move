module 0xc18952c5f2018e7acc78966700c38999678120c15521b7e1d6de016745fa60::vvgf {
    struct VVGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: VVGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVGF>(arg0, 9, b"VVGF", b"yuytu", x"0a416674657220646f696e67206d792067656e6572616c207265736561726368206f6e20746865206d61726b65742c20492061736b203220646966666572656e74206172746966696369616c20696e74656c6c6967656e636520626f74732061626f75742074686520636f696e204920616d20636f6e7369646572696e6720696e76657374696e6720696e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9e1bb370980bf4073089fe2009c6bc59blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VVGF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VVGF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

