module 0x6ee5bfa9acc500f967effee57692f51441d63cb744925238d88cc39165f0473d::myfren {
    struct MYFREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYFREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYFREN>(arg0, 6, b"MYFREN", b"be like water my fren", x"6a757374206772616220796f757220666c6f61746965732c206469766520696e2c20616e64206c6574732072696465207468652077617665206f6620776174612121204974732074696d6520746f206265207468652077617461612c206d79206672656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/my_fren_510b4b9003.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYFREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYFREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

