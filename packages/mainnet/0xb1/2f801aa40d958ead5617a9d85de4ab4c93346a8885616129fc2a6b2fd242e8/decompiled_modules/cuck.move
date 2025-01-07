module 0xb12f801aa40d958ead5617a9d85de4ab4c93346a8885616129fc2a6b2fd242e8::cuck {
    struct CUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCK>(arg0, 6, b"CUCK", b"SUI CUCK", b"OMG! Look how cute he is!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CUCK_efd9023b83.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

