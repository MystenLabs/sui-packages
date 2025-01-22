module 0x3bea8d8559d59d3a738da1580ac75d83876ec7cddf4e3b7e844d4a0cf6da90c0::fridon {
    struct FRIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIDON>(arg0, 6, b"FRIDON", b"Fridon Ai", b"FridonAI leverages AI to enhance the crypto experience, combining intelligent analytics, powerful search, and real-time notifications within a cohesive chat interface", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028303_9135dadf41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIDON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIDON>>(v1);
    }

    // decompiled from Move bytecode v6
}

