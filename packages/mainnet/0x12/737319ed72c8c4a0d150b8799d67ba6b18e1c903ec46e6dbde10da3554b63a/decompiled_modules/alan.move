module 0x12737319ed72c8c4a0d150b8799d67ba6b18e1c903ec46e6dbde10da3554b63a::alan {
    struct ALAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALAN>(arg0, 6, b"ALAN", b"The Creator of Ai", b"$ALAN, inspired by Alan Turing, the father of AI, is a token that celebrates the origins and transformative impact of artificial intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046615_98dc557d54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

