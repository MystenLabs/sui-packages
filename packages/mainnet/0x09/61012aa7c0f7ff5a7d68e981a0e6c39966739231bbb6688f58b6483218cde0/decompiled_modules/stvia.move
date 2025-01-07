module 0x961012aa7c0f7ff5a7d68e981a0e6c39966739231bbb6688f58b6483218cde0::stvia {
    struct STVIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STVIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STVIA>(arg0, 6, b"STVIA", b"SuiTensorVerseIA", x"53756954656e736f725665727365207265766f6c7574696f6e697a6573206163636573736962696c69747920746f206172746966696369616c20696e74656c6c6967656e63652c206f70656e696e672074686520646f6f727320666f7220616c6c20696e646976696475616c7320746f2064656c766520696e746f20616e64206163746976656c7920706172746963697061746520696e2074686520646576656c6f706d656e74206f66204149206d6f64656c730a68747470733a2f2f74656e736f7276657273652e636c6f75642f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitensor_2b0fd92664.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STVIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STVIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

