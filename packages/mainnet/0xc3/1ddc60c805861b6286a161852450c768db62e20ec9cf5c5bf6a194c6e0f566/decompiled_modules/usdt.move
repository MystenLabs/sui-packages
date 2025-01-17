module 0xc31ddc60c805861b6286a161852450c768db62e20ec9cf5c5bf6a194c6e0f566::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Tether USD", b"CS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tether_9a9970d4dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

