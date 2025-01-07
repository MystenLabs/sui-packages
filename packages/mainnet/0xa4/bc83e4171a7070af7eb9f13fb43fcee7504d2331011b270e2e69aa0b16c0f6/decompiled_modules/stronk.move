module 0xa4bc83e4171a7070af7eb9f13fb43fcee7504d2331011b270e2e69aa0b16c0f6::stronk {
    struct STRONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRONK>(arg0, 6, b"Stronk", b"Sui Stronk", b"Power up with $STRONK on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stronk_cedcfa9f48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

