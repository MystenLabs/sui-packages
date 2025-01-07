module 0xee6a37bcbe986a706ef4df99ec7803766ccf0d31e078c271f327d1eeb9f097a2::tff {
    struct TFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFF>(arg0, 9, b"TFF", b"TestcoinForfun", b"This is a test Token, Don't buy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/42486351b0d4163f5a9baaa8cc657500blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TFF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

