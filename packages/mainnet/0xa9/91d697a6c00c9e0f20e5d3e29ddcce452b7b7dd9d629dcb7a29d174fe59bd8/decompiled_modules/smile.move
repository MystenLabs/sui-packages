module 0xa991d697a6c00c9e0f20e5d3e29ddcce452b7b7dd9d629dcb7a29d174fe59bd8::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 6, b"SMILE", b"SMILE", b"Proof of Gratitude Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suizzle.com/wp-content/uploads/2023/01/smile_0001.png.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

