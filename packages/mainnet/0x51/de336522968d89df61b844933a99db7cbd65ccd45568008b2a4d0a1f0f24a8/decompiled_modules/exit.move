module 0x51de336522968d89df61b844933a99db7cbd65ccd45568008b2a4d0a1f0f24a8::exit {
    struct EXIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EXIT>(arg0, 6, 0x1::string::utf8(b"EXIT"), 0x1::string::utf8(b"EXIT LIQUIDITY"), 0x1::string::utf8(x"4576657279206d656d652068617320616e20656e7472792e0a455849542068617320616e20657869740a4558495420e2809420596f75722073746f70206c6f7373206861732061206d656d65206e6f770a4275792074686520746f700a536574207468652045584954"), 0x1::string::utf8(b"https://popularsui.xyz/media/a1dcd25204fa49002c19cd1380ba897d4e7c8691037d0353c44a9e01ec400ca0.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<EXIT>>(0x2::coin_registry::finalize<EXIT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

