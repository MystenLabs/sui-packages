module 0x9a5bcb843e301875a723ae8fb15e4eb50d18409f89b12b0c25d2e1ab0777c05c::cuty {
    struct CUTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTY>(arg0, 6, b"CUTY", b"Cuty", b"Just a cute cat getting a haircut..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_202944_841_79cb80b0cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

