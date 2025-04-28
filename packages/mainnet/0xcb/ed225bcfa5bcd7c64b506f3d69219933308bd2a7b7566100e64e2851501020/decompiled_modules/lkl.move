module 0xcbed225bcfa5bcd7c64b506f3d69219933308bd2a7b7566100e64e2851501020::lkl {
    struct LKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKL>(arg0, 6, b"LKL", b"Little Kid Lovers", b"They love each others", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002799_51d213c652.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

