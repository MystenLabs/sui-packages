module 0x3542e2880909d31f68f05b693a864599b91e92029256a13d933099a01426171e::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 9, b"PNUT", b"Squirrel", x"5045414e555420464f52455645522e20234a757374696365466f725065616e75742e205065616e7574207468650a537175697272656c2069732061206d656d6520636f696e206f6e205375692e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67582aff-7591-44ba-8335-2aeb6ee7da3d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

