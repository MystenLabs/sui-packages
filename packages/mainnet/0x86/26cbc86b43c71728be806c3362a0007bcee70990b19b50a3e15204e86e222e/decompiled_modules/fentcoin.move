module 0x8626cbc86b43c71728be806c3362a0007bcee70990b19b50a3e15204e86e222e::fentcoin {
    struct FENTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENTCOIN>(arg0, 6, b"FENTCOIN", b"FentCoin On Sui", x"66656e74636f696e202d206d656d65636f696e2066726f6d20746865206675747572650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031539_7bfd9eb704.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

