module 0x1f3456fc75d2ac467b032d722e39138d5a85a868b1d114309828532f408c714a::qsui {
    struct QSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QSUI>(arg0, 6, b"QSUI", b"Queen Sui", x"517565656e2053756920517565656e204f6620436861696e73204c657473204d616b652047726561742053554920416761696e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/queen_38f1e6ccec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

