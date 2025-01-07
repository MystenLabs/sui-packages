module 0xde9a6bb3a4e9ac8e8bf7dcea23aeb6b38e9f3ed3c515e3578b13b5ced9d9f102::ozzy {
    struct OZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZZY>(arg0, 6, b"OZZY", b"SUI OZZY", b"SuiOzzy, also known as $OZZY is an otter coin created out of love for otters with the aim of helping and growing with other communities on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731435373883.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZZY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZZY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

