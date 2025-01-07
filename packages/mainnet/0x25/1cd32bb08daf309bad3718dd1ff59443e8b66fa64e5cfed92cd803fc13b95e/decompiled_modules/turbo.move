module 0x251cd32bb08daf309bad3718dd1ff59443e8b66fa64e5cfed92cd803fc13b95e::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 6, b"Turbo", b"Turbo Sui", x"546865206661737465737420736e61696c206f6e207468652073756920636861696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730437587374.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

