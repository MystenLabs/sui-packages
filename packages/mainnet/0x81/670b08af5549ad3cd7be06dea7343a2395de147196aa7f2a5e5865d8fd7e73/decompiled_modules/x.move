module 0x81670b08af5549ad3cd7be06dea7343a2395de147196aa7f2a5e5865d8fd7e73::x {
    struct X has drop {
        dummy_field: bool,
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 9, b"X", b"Atilaa", x"c38174696c61277320436f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<X>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v2, @0xb8bff1e31dedc928aeac94d41fd68775af4d36249a6be4bc60c3dce9533040ac);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X>>(v1);
    }

    // decompiled from Move bytecode v6
}

