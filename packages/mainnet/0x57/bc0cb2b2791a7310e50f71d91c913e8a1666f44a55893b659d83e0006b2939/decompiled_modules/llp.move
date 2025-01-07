module 0x57bc0cb2b2791a7310e50f71d91c913e8a1666f44a55893b659d83e0006b2939::llp {
    struct LLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLP>(arg0, 9, b"LLP", b"LLP", b"The coin for Luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.luckystar.homes/_next/static/media/logo.0fcacc03.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LLP>>(0x2::coin::mint<LLP>(&mut v2, 1500000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

