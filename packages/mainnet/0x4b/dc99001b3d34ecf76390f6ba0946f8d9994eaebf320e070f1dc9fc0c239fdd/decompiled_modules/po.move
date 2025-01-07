module 0x4bdc99001b3d34ecf76390f6ba0946f8d9994eaebf320e070f1dc9fc0c239fdd::po {
    struct PO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PO>(arg0, 6, b"PO", b"Po The Polar Bear", b"Po is sailing the SUI Seas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4268acc9bb523b67c92fc03bcc437ebf_8951235708.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PO>>(v1);
    }

    // decompiled from Move bytecode v6
}

