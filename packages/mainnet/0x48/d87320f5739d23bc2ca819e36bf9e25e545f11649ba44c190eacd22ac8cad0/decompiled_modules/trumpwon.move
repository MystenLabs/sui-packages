module 0x48d87320f5739d23bc2ca819e36bf9e25e545f11649ba44c190eacd22ac8cad0::trumpwon {
    struct TRUMPWON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWON>(arg0, 6, b"TRUMPWON", b"TrumpWon Sui", b"$TrumpWon Memecoin is here to make crypto great again! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002328_d5b3418b81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWON>>(v1);
    }

    // decompiled from Move bytecode v6
}

