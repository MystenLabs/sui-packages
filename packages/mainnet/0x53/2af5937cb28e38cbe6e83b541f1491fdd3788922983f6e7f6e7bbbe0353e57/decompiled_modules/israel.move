module 0x532af5937cb28e38cbe6e83b541f1491fdd3788922983f6e7f6e7bbbe0353e57::israel {
    struct ISRAEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISRAEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISRAEL>(arg0, 6, b"Israel", b"israel", x"0a546865204a65776973682050656f706c6520537570706f72742043757272656e63792c20666f756e6465642062792074686520576f726c64204a657769736820436f6e677265737320696e20706172746e65727368697020776974682049737261656c20546563686e6f6c6f676965732c20686173207472656d656e646f757320646576656c6f706d656e7473206f6e207468652077617920457370656369616c6c7920696e20746865206669656c64206f66206172746966696369616c20696e74656c6c6967656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/isra_529f499ea5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISRAEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISRAEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

