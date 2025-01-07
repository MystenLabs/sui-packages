module 0x85fca647801f35d00dbaa5d9fd423d86bb86e68507c178182443ac21bf6a03fa::polcow {
    struct POLCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLCOW>(arg0, 6, b"POLCOW", b"dancing poland cow", b"DANCING POLAND CORW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/161083354763584233_367c8fc960.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLCOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

