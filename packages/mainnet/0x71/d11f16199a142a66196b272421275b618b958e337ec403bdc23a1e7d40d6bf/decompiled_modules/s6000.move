module 0x71d11f16199a142a66196b272421275b618b958e337ec403bdc23a1e7d40d6bf::s6000 {
    struct S6000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S6000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S6000>(arg0, 6, b"S6000", b"SUI 6000", b"6000 $SUI in the bonding curve is the first step. $1m market cap next!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9490_02e0c6442b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S6000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S6000>>(v1);
    }

    // decompiled from Move bytecode v6
}

