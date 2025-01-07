module 0x8edb6137a425c1c9db57c7d33cfb643cfa21ba86d5c8785a0106e9cf9c08f96f::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGO>(arg0, 6, b"GROGGO", b"Groggo on SUI", x"47726f67676f20697320746865206f6e6c7920626c75652066726f6720696e20616c6c206f66204d617474204675726965277320626f6f6b732c20616464696e672068696d20746f2068697320636f6c6c656374696f6e206f6620656e64656172696e672066726f6773207468617420776520616c6c206c6f76652e2044756520746f2068697320726573656d626c616e636520746f20506570652c20736f6d652063616c6c2068696d2054686520426c756520506570652e20546865726520636f756c646e27742062652061206265747465722066697420666f722074686520535549206e6574776f726b2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2e0d7bf101.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

