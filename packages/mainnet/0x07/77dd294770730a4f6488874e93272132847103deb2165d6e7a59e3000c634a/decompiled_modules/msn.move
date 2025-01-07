module 0x777dd294770730a4f6488874e93272132847103deb2165d6e7a59e3000c634a::msn {
    struct MSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSN>(arg0, 6, b"MSN", b"Mew Sui Network", b"Fan token of the cute powerful mew. Watch mew burn the supply. Tokens will be burned weekly. Until 5 percent of supply is burned!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5524_344e8d5b9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

