module 0xf63a724e2de3df5a6a7b1940d0a571558be3bba2c1a3665cfce834304bfeb9e0::tits {
    struct TITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITS>(arg0, 6, b"TITS", b"We Love Tits", b"WE LOVE $TITS - The only thing we can all universally agree on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016699_af9f3894d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

