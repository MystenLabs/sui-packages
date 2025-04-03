module 0x15b30cb7f1f5c6a25e898b7d5ac56790eadffc7561db9ca09e446a5af0cd978a::pepig {
    struct PEPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPIG>(arg0, 6, b"PEPIG", b"Pepig", x"526973656e2066726f6d206e6f7468696e672c0a6372656174656420746f20736861706520746865206675747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053469_9ad58080c0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

