module 0xf817ed2cdd2f52bcb035a2d5ffde150e2211a1f267f4c2c7e5857f361cd3baa6::trumpwon {
    struct TRUMPWON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWON>(arg0, 6, b"TRUMPWON", b"Trumwon On Sui", b"$TrumpWon Memecoin is here to make crypto great again! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002363_8b99f984d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWON>>(v1);
    }

    // decompiled from Move bytecode v6
}

