module 0x8ff140c8ac9f3c74a69efacc3c2f05c818185862e58a4300a99307b9d5b6ebed::tyty {
    struct TYTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYTY>(arg0, 9, b"tytydd", b"tyty", b"tytytytytyty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

