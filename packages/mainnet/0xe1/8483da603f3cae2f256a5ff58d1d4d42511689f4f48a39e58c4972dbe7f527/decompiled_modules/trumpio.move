module 0xe18483da603f3cae2f256a5ff58d1d4d42511689f4f48a39e58c4972dbe7f527::trumpio {
    struct TRUMPIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPIO>(arg0, 6, b"TRUMPIO", b"Trump Mario", b"A combo you never saw coming. Trump as Mario, ready to power up and take over Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_0b32f337cb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

