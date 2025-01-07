module 0x8429b11cf3c583bb6e6a109031a36c3af747e124e581c7e4f9268007e3d0091b::firoll {
    struct FIROLL has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"FIROLL", b"PE", b"FIROLL is a pioneering token on the Sui network, designed for decentralized gaming and betting applications.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://your-icon-url.com/firoll.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: FIROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<FIROLL>(arg0, arg1);
        0x2::coin::mint_and_transfer<FIROLL>(&mut v0, 10000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIROLL>>(v0);
    }

    // decompiled from Move bytecode v6
}

