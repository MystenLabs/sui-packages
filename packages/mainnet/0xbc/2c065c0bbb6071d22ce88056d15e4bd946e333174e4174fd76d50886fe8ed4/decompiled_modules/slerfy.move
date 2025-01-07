module 0xbc2c065c0bbb6071d22ce88056d15e4bd946e333174e4174fd76d50886fe8ed4::slerfy {
    struct SLERFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLERFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLERFY>(arg0, 6, b"Slerfy", b"Slerfy Community", b"Slerfy is Slerf's son and he still young and wild", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020848_0029691a6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLERFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLERFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

