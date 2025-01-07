module 0xa1fb38d0e7adc99ffd025b7839586f8663b85cbe735014517ca113b33144c79e::hfish {
    struct HFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFISH>(arg0, 6, b"HFISH", b"HUNGRY FISH", b"Hunger is coming to FISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0069ba9edf1f99c81ec48f55a1ee670d_4ecbea5ee9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

