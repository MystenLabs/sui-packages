module 0xe88269a3e63a34a3c029d27f28a972376381a6b163582be9d1a7f5b84becb255::timi {
    struct TIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIMI>(arg0, 6, b"TIMI", b"TIMItheCat", b"A cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/timi_94a7d0ede9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

