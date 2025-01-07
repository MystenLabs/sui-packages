module 0xaecbbc700d0a8f62469d0684a8434b45862e633c4d754687efbce7a78b038fb7::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 6, b"RONDA", b"Ronda", x"24526f6e6461204f6e20537569206f6e2074686520526f616420746f2042696767657220616e6420426574746572205468696e677321204e65766572204c6f6f6b696e67204261636b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6040937064956016135_6655fcad39.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

