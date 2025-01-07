module 0x7a2ed1e53789f719172598bb500868b88496a059b1bda5f3832c37d9cfec044::btc6900 {
    struct BTC6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC6900>(arg0, 6, b"BTC6900", b"Sui BTC6900", b"\"When the moon shine, and the memes fly high!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0573_d856e4aa18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

