module 0x526a1d0711a0ad48d23f738f501885b6303e140ff45cb534212e69a3a33f01ac::alan {
    struct ALAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAN>(arg0, 6, b"ALAN", b"ALAN - AI Trader", b" Our AI-powered platform automatically trains and optimizes trading strategies based on your input, ensuring you stay ahead of the dynamically changing crypto market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Qkemuq_400x400_cdb60d8372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

