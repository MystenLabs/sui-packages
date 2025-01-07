module 0x2d40c4881896dbd6288a8d6449ce755d5b44ac84710e5864a6936006333905cd::xlb {
    struct XLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XLB>(arg0, 6, b"XLB", b"xiaolaoban", b"xiaolaoban", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/images_6_0b2bb17bc1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XLB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

