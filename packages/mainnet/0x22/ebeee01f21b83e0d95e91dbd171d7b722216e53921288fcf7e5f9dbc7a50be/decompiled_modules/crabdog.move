module 0x22ebeee01f21b83e0d95e91dbd171d7b722216e53921288fcf7e5f9dbc7a50be::crabdog {
    struct CRABDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABDOG>(arg0, 6, b"CRABDOG", b"Crab Dog", x"4974e2809973206120646f672e204974e2809973206120637261622e204974e2809973202443524142444f472e205468652073696465776179732073637574746c696e67206c6567656e64206865726520746f20636c617720746865206d61726b657420616e64206665746368206d656d65732e202254776f20636c6177732c206f6e65206261726b2c20656e646c6573732076696265732e220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732265081237.25")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRABDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

