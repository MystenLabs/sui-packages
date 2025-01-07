module 0xcd1ef1806759e5ece3abddafda35df34721d663ce6aa24f8872108541db9b0ce::tago {
    struct TAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAGO>(arg0, 6, b"TAGO", b"Tago on sui", b"Come and join $TIGO The Toothless Monster on his adventure through SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056353_d8b9f58bfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

