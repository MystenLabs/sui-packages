module 0x92f84c1dd74a465ea005983f452830000b0ddbbf6feeac286e27c79f849f31ec::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 9, b"BALL", b"Ballbert", b"Ballbert is 90% air, 10% vibes, and somehow owns three yachts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a08054825e7dc5c0dc70a88aaac90e0cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

