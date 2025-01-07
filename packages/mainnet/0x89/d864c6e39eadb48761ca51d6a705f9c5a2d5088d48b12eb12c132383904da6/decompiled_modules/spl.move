module 0x89d864c6e39eadb48761ca51d6a705f9c5a2d5088d48b12eb12c132383904da6::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL>(arg0, 6, b"SPL", b"SPLO SUI", b"SPLO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPLO_e74e45a417.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

