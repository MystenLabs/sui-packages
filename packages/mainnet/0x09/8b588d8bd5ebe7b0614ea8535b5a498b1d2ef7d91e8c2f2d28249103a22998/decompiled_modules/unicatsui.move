module 0x98b588d8bd5ebe7b0614ea8535b5a498b1d2ef7d91e8c2f2d28249103a22998::unicatsui {
    struct UNICATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNICATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNICATSUI>(arg0, 6, b"Unicatsui", b"Unicat", b"Suiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000908765_2fbab04e33.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNICATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNICATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

