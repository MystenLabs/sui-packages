module 0x569a4f28f69212b17f94c62e820869d79fe2b57f00be214bd62f16fd75ac6048::bmp {
    struct BMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMP>(arg0, 6, b"BMP", b"Binance Moonbix Points", b"Binance Moonbix Points on Sui is token based on the King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000133437_75d68a07d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

