module 0x22aa9a78b580dc9d2e4e8f37afa6075d1140de6746f4887fa3168532a882692c::mtn {
    struct MTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTN>(arg0, 6, b"MTN", b"Montana", b"Montana, the blue fox, is a spirited and adventurous soul with a playful charm. With a coat that glimmers like a midnight sky, he captures attention effortlessly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Montana_17df3cb51c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

