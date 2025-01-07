module 0x6f2a2401d8eafc70b55ca05fa257d4e77e60d1a06db4b881e331a8c6852dd2de::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 6, b"HI", b"Human Intelligence", b"The future of human intelligence may involve a fusion of biological and technological advancements, enhancing cognitive abilities through neurotechnology and artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V_Kpz2_r6_400x400_6a6c6972e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HI>>(v1);
    }

    // decompiled from Move bytecode v6
}

