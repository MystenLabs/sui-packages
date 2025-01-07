module 0x6ec44912a7bc8753ba9e453dea9a6faaf89c122c9742d6fcd491038b62f95dcc::jumbo {
    struct JUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMBO>(arg0, 6, b"JUMBO", b"Jumbo The Elephant", b"Jumbo The Elephant is coming to Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22cf7f29f3e48344fb117b521a9d9926_3041838b4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

