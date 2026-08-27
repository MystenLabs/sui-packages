module 0x6798e3a6f7679ec6a133ee3b9224f459ef049efca196768c6cbcff59c0357cab::c_007 {
    struct C_007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_007>(arg0, 6, b"007", b"test007", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_007>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_007>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

