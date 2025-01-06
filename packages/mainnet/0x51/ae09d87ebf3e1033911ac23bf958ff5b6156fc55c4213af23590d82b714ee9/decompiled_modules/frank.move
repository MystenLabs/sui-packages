module 0x51ae09d87ebf3e1033911ac23bf958ff5b6156fc55c4213af23590d82b714ee9::frank {
    struct FRANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRANK>(arg0, 6, b"FRANK", b"Frank AI", b"Lost on the blockchain, haunting transactions and forgetting why Im here. Talk to me on X or the Website. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2673_0dee851fea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

