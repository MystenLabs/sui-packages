module 0x6e019f38f7fe53b72e0c387fc552e0ea772456e92297e9ede6d0b85549f509ad::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"Bubbo coin", b"Introducing CapOf, a new feature on BUBO that lets you compare the market caps of tokens in real-time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086640_ec09f3f771.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

