module 0x3b194a22b451ee6783b34e0bf7b6c2261aa72a3a1e9f97b5949cdebae96fd26d::stv {
    struct STV has drop {
        dummy_field: bool,
    }

    fun init(arg0: STV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STV>(arg0, 6, b"STV", b"SuiTenVerseIA", x"53756954656e736f725665727365207265766f6c7574696f6e697a6573206163636573736962696c69747920746f206172746966696369616c20696e74656c6c6967656e63652c206f70656e696e672074686520646f6f727320666f7220616c6c20696e646976696475616c7320746f2064656c766520696e746f20616e64206163746976656c7920706172746963697061746520696e2074686520646576656c6f706d656e74206f66204149206d6f64656c730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitensor_2b0fd92664.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STV>>(v1);
    }

    // decompiled from Move bytecode v6
}

