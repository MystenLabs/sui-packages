module 0x96861fe5fad5b52bcb35559569fdbf08dcc8970dd8b1a6a6a1aa1f3334518cbd::sign {
    struct SIGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGN>(arg0, 9, b"SiGN", b"mini SIGN", b"its a top agree based project on X , doing intraction with community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/905211a62c1400245b0cabf2f05aa31ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

