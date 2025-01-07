module 0x3b58e66e588c2e4af9e604270b63569e8cee38ad8ee1d9cbe614c97548033f1e::coat {
    struct COAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COAT>(arg0, 6, b"COAT", b"SUI COAT", b"HI IM SUI COAT LFG WITH ME ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/78ec9e1c038f4ec5da6fc394437fdf89_9b3e090d0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

