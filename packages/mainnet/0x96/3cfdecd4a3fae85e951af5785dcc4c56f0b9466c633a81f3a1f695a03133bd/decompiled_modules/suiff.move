module 0x963cfdecd4a3fae85e951af5785dcc4c56f0b9466c633a81f3a1f695a03133bd::suiff {
    struct SUIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFF>(arg0, 6, b"SUIFF", b"Suiff", b"The OG meme coin on the SUI Chain, letting you earn $SUI while staking $SUIFF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_13_26_49_6c0f6e4340.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

