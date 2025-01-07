module 0x813a9aa7f1c06919efeacb14b2fdcb9dd0b341b0285727d59e3e45370d6b9a74::lilly {
    struct LILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILLY>(arg0, 6, b"LILLY", b"Lilly AI", b"Lilly AI is an intelligent, multi-modal AI Character streaming live, reacting to trends, chats, and news while showing emotions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1212312323_b2c89ec47a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

