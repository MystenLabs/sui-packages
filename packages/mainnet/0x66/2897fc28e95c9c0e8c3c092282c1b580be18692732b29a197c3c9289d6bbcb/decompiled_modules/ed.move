module 0x662897fc28e95c9c0e8c3c092282c1b580be18692732b29a197c3c9289d6bbcb::ed {
    struct ED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ED>(arg0, 6, b"Ed", b"Elondona", b"when Elon musk and Donald trump meet great things happen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xx_G2_Foo_400x400_da5169316e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ED>>(v1);
    }

    // decompiled from Move bytecode v6
}

