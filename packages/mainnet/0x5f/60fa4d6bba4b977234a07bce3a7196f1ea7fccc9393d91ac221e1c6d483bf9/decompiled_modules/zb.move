module 0x5f60fa4d6bba4b977234a07bce3a7196f1ea7fccc9393d91ac221e1c6d483bf9::zb {
    struct ZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZB>(arg0, 6, b"ZB", b"ZeroByte", b"ZeroByte is a new AI Agent created in", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H_Uu_Lq_Iz_D_400x400_bceb97035a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZB>>(v1);
    }

    // decompiled from Move bytecode v6
}

