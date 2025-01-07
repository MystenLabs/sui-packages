module 0x568687185e7d8d0f99a0b3c3166afd0432e0ad43a848fa8f554cac401b968122::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 6, b"BRO", b"Ditto the Bro", b"WHO DOES BRO THINK HE IS? The most memeable bro in Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_50761c0b8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

