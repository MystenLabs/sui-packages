module 0xefd56295263e11fed40a4ddefc0d427ac85af78ce9e5788235114c360b0d10b9::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 6, b"BUL", b"Bul", b"he is coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bus_8c830d5082.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

