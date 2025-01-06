module 0xde82dd5cc133059dd7e76f5af46e7ece0ce08577a9b3e84a1031ff73ec236fc7::titam {
    struct TITAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAM>(arg0, 6, b"TITAM", b"THE TITANS", b"The token is finally live!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tit_e3063407a5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

