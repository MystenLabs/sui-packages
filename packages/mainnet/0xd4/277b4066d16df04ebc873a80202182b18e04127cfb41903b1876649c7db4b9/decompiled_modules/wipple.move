module 0xd4277b4066d16df04ebc873a80202182b18e04127cfb41903b1876649c7db4b9::wipple {
    struct WIPPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIPPLE>(arg0, 6, b"WIPPLE", b"WIDE RIPPLE", b"WIPLLE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_19_34_21_f2b1c0e5c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIPPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIPPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

