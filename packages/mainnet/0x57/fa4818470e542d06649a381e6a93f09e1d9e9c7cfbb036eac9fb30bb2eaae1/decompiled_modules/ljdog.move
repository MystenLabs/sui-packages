module 0x57fa4818470e542d06649a381e6a93f09e1d9e9c7cfbb036eac9fb30bb2eaae1::ljdog {
    struct LJDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LJDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LJDOG>(arg0, 6, b"LJDOG", b"life jacket dog", b"Relax Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0755_6e8696ab0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LJDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LJDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

