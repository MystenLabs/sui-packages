module 0x25b92a0b8d7860aa745b05df51728ac95a65d9b98c177385666a13cba24fa4ee::ron {
    struct RON has drop {
        dummy_field: bool,
    }

    fun init(arg0: RON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RON>(arg0, 9, b"RON", b"Robinson", b"Super Coin hidden gem Gold Coin Billion Coin Natural Coin Mega Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/398792009738bc374f2b507f5af4b661blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

