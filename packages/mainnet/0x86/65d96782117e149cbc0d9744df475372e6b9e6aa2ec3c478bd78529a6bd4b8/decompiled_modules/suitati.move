module 0x8665d96782117e149cbc0d9744df475372e6b9e6aa2ec3c478bd78529a6bd4b8::suitati {
    struct SUITATI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATI>(arg0, 6, b"SUITATI", b"SUITATO ON SUI", b"Suitato, the potato in a suit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000436_37d5f0bafa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITATI>>(v1);
    }

    // decompiled from Move bytecode v6
}

